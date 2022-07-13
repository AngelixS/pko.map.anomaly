if not Anomaly then
	Anomaly = {}
	Anomaly.Conf = {}
	Anomaly.Conf.Require = {}
	Anomaly.Conf.Attribute = {}
	Anomaly.Conf.MonsterSpawn = {}

	Anomaly.Message = {NPC = {}}
	Anomaly.Instance = {}
	Anomaly.Player = {}
	Anomaly.Floor = nil

	Anomaly.KickStart = false
end

dofile(GetResPath("Anomaly/Anomaly Configuration.lua"))
Anomaly.Monster = dofile(GetResPath("Anomaly/Anomaly Attribute Monster.lua"))
Anomaly.MiniBoss = dofile(GetResPath("Anomaly/Anomaly Attribute MiniBoss.lua"))
Anomaly.Boss = dofile(GetResPath("Anomaly/Anomaly Attribute Boss.lua"))
dofile(GetResPath("Anomaly/Anomaly Floor Configuration.lua"))
dofile(GetResPath("Anomaly/Anomaly Reward.lua"))
dofile(GetResPath("Anomaly/Anomaly NPC.lua"))

Anomaly.Reload = function()
	dofile(GetResPath("Anomaly/ctrl.lua"))
	dofile(GetResPath("Anomaly/entry.lua"))
end
Anomaly.AvailableInstance = function()
	for Num, Instance in pairs(Anomaly.Instance) do
		if not Instance.Init then
			return Num
		end
	end
	return 0
end
Anomaly.InstanceReset = function(CopyID)
	Anomaly.Instance[CopyID] = {}

	Anomaly.Instance[CopyID].Monster = {}

	Anomaly.Instance[CopyID].Init = false
	Anomaly.Instance[CopyID].Finish = false
	Anomaly.Instance[CopyID].Summon = false

	Anomaly.Instance[CopyID].Floor = 0
	Anomaly.Instance[CopyID].Time = 0
	Anomaly.Instance[CopyID].KickTime = 5
	Anomaly.Instance[CopyID].MonsterKill = 0
	Anomaly.Instance[CopyID].MonsterCount = 0
end

Anomaly.Register = function(Player, NPC)
	if not Anomaly.Conf.Enable then
		HelpInfo(Player, NPC, string.format(Anomaly.Conf.Text.NPC.NotEnabled, Anomaly.Conf.NameNPC, Anomaly.Conf.Name))
		return LUA_FALSE
	end
    local Count, Ret = Anomaly.CheckTeam(Player)
    if not Ret then
        HelpInfo(Player, NPC, string.format(Anomaly.Message.NPC.NotQualify, Anomaly.Conf.Name))
        return LUA_FALSE
    end
    if Anomaly.Conf.Players == 1 and IsInTeam(Player) == LUA_TRUE then
        HelpInfo(Player, NPC, string.format(Anomaly.Message.NPC.NotSolo, Anomaly.Conf.Name))
        return LUA_FALSE
    elseif Anomaly.Conf.Players > 1 then
        if IsTeamLeader(Player) == LUA_FALSE then
            HelpInfo(Player, NPC, string.format(Anomaly.Message.NPC.OnyLeader, Anomaly.Conf.Name))
            return LUA_FALSE
        end
        if IsInTeam(Player) == LUA_FALSE or Count < Anomaly.Conf.Players then
            HelpInfo(Player, NPC, string.format(Anomaly.Message.NPC.NotTeam, Anomaly.Conf.Name, Anomaly.Conf.Players))
            return LUA_FALSE
        end
    end
	local Name = GetChaDefaultName(Player)
	local PlayerID = GetRoleID(Player)
	if (Anomaly.Player[PlayerID].Floor + 1) > Anomaly.Conf.FloorLimit then
		HelpInfo(Player, NPC, string.format(Anomaly.Message.NPC.FloorLimit, Anomaly.Conf.NameNPC, Anomaly.Conf.Name))
		return LUA_FALSE
	end
	--	Check if there's an available instance.
	local CopyID = Anomaly.AvailableInstance()
	if CopyID == 0 then
        HelpInfo(Player, NPC, string.format(Anomaly.Message.NPC.NoFreeInstance, Anomaly.Conf.Name))
        return LUA_FALSE
	end
	Anomaly.InstanceReset(CopyID)
	Anomaly.Instance[CopyID].Init = true
	Anomaly.Instance[CopyID].Floor = Anomaly.Player[PlayerID].Floor + 1

	local Players = {Player, GetTeamCha(Player, 0), GetTeamCha(Player, 1), GetTeamCha(Player, 2), GetTeamCha(Player, 3)}
	for _, PlayerI in pairs(Players) do
		MoveCity(PlayerI, Anomaly.Conf.Name, CopyID)
	end
	return LUA_TRUE
end
Anomaly.CheckTeam = function(Player)
	local Players = {Player, GetTeamCha(Player, 0), GetTeamCha(Player, 1), GetTeamCha(Player, 2), GetTeamCha(Player, 3)}
	local Count, Ret = 0, true
	for _, PlayerI in pairs(Players) do
		local Level = GetChaAttrI(PlayerI, ATTR_LV)
		local Name = GetChaDefaultName(PlayerI)
		if Anomaly.Conf.Require.MinLevel ~= 0 and Level < Anomaly.Conf.Require.MinLevel then
			SystemNotice(PlayerI, string.format(Anomaly.Conf.Text.NPC.AboveLevel, Anomaly.Conf.NameNPC, Anomaly.Conf.Require.MinLevel, Anomaly.Conf.Name))
			Ret = false
		end
		if Anomaly.Conf.Require.MaxLevel ~= 0 and Level > Anomaly.Conf.Require.MaxLevel then
			SystemNotice(PlayerI, string.format(Anomaly.Conf.Text.NPC.BelowLevel, Anomaly.Conf.NameNPC, Anomaly.Conf.Require.MaxLevel, Anomaly.Conf.Name))
			Ret = false
		end
		Anomaly.LoadPlayer(PlayerI)
		Count = Count + 1
	end
	return Count, Ret
end
Anomaly.LoadPlayer = function(Player)
	local Name = GetChaDefaultName(Player)
	local PlayerID = GetRoleID(Player)
	local Path = GetResPath(Anomaly.Conf.Cache..string.format('%010d', GetRoleID(Player))..Anomaly.Conf.CacheExt)
	if not Anomaly.Player[PlayerID] then
		if file_exists(Path) then
			Anomaly.Player[PlayerID] = table.load(Path)
			Anomaly.Player[PlayerID].Name = Name
		else
			Anomaly.Player[PlayerID] = {Name = Name, Floor = 0, Help = 0}
			table.save(Anomaly.Player[PlayerID], Path)
		end
	end
	table.save(Anomaly.Player[PlayerID], Path)
end
Anomaly.SavePlayer = function(Player)
	local Name = GetChaDefaultName(Player)
	local PlayerID = GetRoleID(Player)
	local Path = GetResPath(Anomaly.Conf.Cache..string.format('%010d', GetRoleID(Player))..Anomaly.Conf.CacheExt)
	Anomaly.Player[PlayerID].Name = Name
	table.save(Anomaly.Player[PlayerID], Path)
end
Anomaly.GenerateFloors = function()
	local Path = GetResPath(Anomaly.Conf.Cache..Anomaly.Conf.FloorCache..Anomaly.Conf.CacheExt)
	if not Anomaly.Floor then
		if file_exists(Path) then
			Anomaly.Floor = table.load(Path)
		else
			Anomaly.Floor = {}
			table.save(Anomaly.Floor, Path)
		end
	end
	for Num = 1, Anomaly.Conf.FloorLimit, 1 do
		if not Anomaly.Floor[Num] then
			Anomaly.Floor[Num] = {Monsters = {}, MiniBoss = {}, Boss = {}}
			if (Num - math.floor(Num / 10) * 10) == 0 then
				local BossID, _ = Anomaly.Random(Anomaly.Boss)
				table.insert(Anomaly.Floor[Num].Boss, BossID)
			elseif (Num - math.floor(Num / 5) * 5) == 0 then
				local MiniBossID, _ = Anomaly.Random(Anomaly.MiniBoss)
				table.insert(Anomaly.Floor[Num].MiniBoss, MiniBossID)
			end
			for Count = 1, 4, 1 do
				local MonsterID, _ = Anomaly.Random(Anomaly.Monster)
				table.insert(Anomaly.Floor[Num].Monsters, MonsterID)
			end
		end
	end
	table.save(Anomaly.Floor, Path)
end
Anomaly.Random = function(Table)
	local Sum = 0
	for _, Thing in pairs(Table) do
		Sum = Sum + (Thing.Rate or 1)
	end
    local ID, Choice = 0, nil
	local Index = math.random() * Sum
	for Num, Thing in pairs(Table) do
		Thing.Rate = Thing.Rate or 1
		if Index < Thing.Rate then
			ID, Choice = Num, Thing
            break
		else
			Index = Index - Thing.Rate
	    end
	end
    return ID, Choice
end
Anomaly.Multiplier = function(FloorLevel)
	local Normal = 1 + (Anomaly.Conf.Attribute.Normal * FloorLevel)
	local Medium = Normal + Anomaly.Conf.Attribute.Medium
	local Final = Normal + Anomaly.Conf.Attribute.Final
	return Normal, Medium, Final
end
Anomaly.Summon = function(MapCopy, CopyID, Floor)
	local Normal, Medium, Final = Anomaly.Multiplier(Floor)
	for _, MonsterID in pairs(Anomaly.Floor[Floor].Boss) do
		local PosX = math.random(Anomaly.Conf.MonsterSpawn.PosX.Min, Anomaly.Conf.MonsterSpawn.PosX.Max)
		local PosY = math.random(Anomaly.Conf.MonsterSpawn.PosY.Min, Anomaly.Conf.MonsterSpawn.PosY.Max)
		local Monster = CreateChaEx(MonsterID, (PosX * 100), (PosY * 100), 145, 60, MapCopy)
		SetChaLifeTime(Monster, 999999999)
		Anomaly.SetAttribute(Monster, Anomaly.Boss, Final, Floor + 10)
	end
	for _, MonsterID in pairs(Anomaly.Floor[Floor].MiniBoss) do
		local PosX = math.random(Anomaly.Conf.MonsterSpawn.PosX.Min, Anomaly.Conf.MonsterSpawn.PosX.Max)
		local PosY = math.random(Anomaly.Conf.MonsterSpawn.PosY.Min, Anomaly.Conf.MonsterSpawn.PosY.Max)
		local Monster = CreateChaEx(MonsterID, (PosX * 100), (PosY * 100), 145, 60, MapCopy)
		SetChaLifeTime(Monster, 999999999)
		Anomaly.SetAttribute(Monster, Anomaly.MiniBoss, Medium, Floor + 5)
	end
	for _, MonsterID in pairs(Anomaly.Floor[Floor].Monsters) do
		local PosX = math.random(Anomaly.Conf.MonsterSpawn.PosX.Min, Anomaly.Conf.MonsterSpawn.PosX.Max)
		local PosY = math.random(Anomaly.Conf.MonsterSpawn.PosY.Min, Anomaly.Conf.MonsterSpawn.PosY.Max)
		local Monster = CreateChaEx(MonsterID, (PosX * 100), (PosY * 100), 145, 60, MapCopy)
		SetChaLifeTime(Monster, 999999999)
		Anomaly.SetAttribute(Monster, Anomaly.Monster, Normal, Floor)
	end
end
Anomaly.SetAttribute = function(Monster, MonsterVar, Multiplier, Level)
	local MonsterID = GetChaID(Monster)
	local MapCopy = GetChaMapCopy(Monster)
	local CopyID = GetMapCopyID2(MapCopy)

	Anomaly.Instance[CopyID].Monster[Monster] = true

	Anomaly.Instance[CopyID].MonsterCount = Anomaly.Instance[CopyID].MonsterCount + 1
	SetCharaAttr(Level, Monster, ATTR_LV)

	for AttrNum, AttrValue in pairs(MonsterVar[MonsterID]) do
		local Value = AttrValue * Multiplier
		if AttrNum == ATTR_BMXHP then
			SetCharaAttr(Value, Monster, AttrNum)
			SetCharaAttr(Value, Monster, ATTR_HP)
		else
			SetCharaAttr(Value, Monster, AttrNum)
		end
	end

	if Anomaly.Conf.Test then
		SetChaAIType(Monster, 0)
	end
    ExAttrSet(Monster)
    SyncChar(Monster, 4)
end
Anomaly.PKM = function(Monster, Player)
	local MapCopy = GetChaMapCopy(Player)
	local CopyID = GetMapCopyID2(MapCopy)
	if Anomaly.Instance[CopyID].MonsterKill < Anomaly.Instance[CopyID].MonsterCount then
		if Anomaly.Instance[CopyID].Monster[Monster] then
			Anomaly.Instance[CopyID].MonsterKill = Anomaly.Instance[CopyID].MonsterKill + 1
		end
		if Anomaly.Instance[CopyID].MonsterKill == Anomaly.Instance[CopyID].MonsterCount then
			Anomaly.Instance[CopyID].Finish = true
		end
		print(Anomaly.Instance[CopyID].Finish)
	end
end
Anomaly.Finish = function(Player)
	local MapCopy = GetChaMapCopy(Player)
	local CopyID = GetMapCopyID2(MapCopy)
	local Floor = Anomaly.Instance[CopyID].Floor
	local PlayerID = GetRoleID(Player)
	if Anomaly.Player[PlayerID].Floor == (Floor - 1) then
		Anomaly.Player[PlayerID].Floor = Anomaly.Player[PlayerID].Floor + 1
		Anomaly.HandleRewardMain(Player, Floor)
	else
		Anomaly.Player[PlayerID].Help = Anomaly.Player[PlayerID].Help + 1
		Anomaly.HandleRewardSupport(Player, Floor)
	end
	Anomaly.SavePlayer(Player)
end
Anomaly.MapCopyRun = function(MapCopy, CopyID)
	if not Anomaly.Conf.Enable or not Anomaly.Instance[CopyID].Init or GetMapCopyPlayerNum(MapCopy) == 0 then
		Anomaly.InstanceReset(CopyID)
		ClearAllSubMapCha(MapCopy)
		ClearAllSubMapMonster(MapCopy)
		CloseMapCopy(Anomaly.Conf.Map, CopyID)
		return
	end
	if not Anomaly.Instance[CopyID].Summon then
		Anomaly.Instance[CopyID].Summon = true
		Anomaly.Summon(MapCopy, CopyID, Anomaly.Instance[CopyID].Floor)
	end
	if Anomaly.Instance[CopyID].Finish then
		if Anomaly.Instance[CopyID].KickTime == 0 then
			DealAllPlayerInMap(MapCopy, 'Anomaly_Finish')
			Anomaly.InstanceReset(CopyID)
			ClearAllSubMapCha(MapCopy)
			ClearAllSubMapMonster(MapCopy)
			CloseMapCopy(Anomaly.Conf.Map, CopyID)
			return
		else
			Anomaly.Instance[CopyID].KickTime = Anomaly.Instance[CopyID].KickTime - 1
		end
	end
	Anomaly.Instance[CopyID].Time = Anomaly.Instance[CopyID].Time + 1
end
Anomaly.AfterEnter = function(Player, MapCopy, CopyID)
end
Anomaly.BeforeLeave = function(Player, MapCopy, CopyID)
end
Anomaly.CreateBirthPoint = function()
	for _, Spawn in pairs(Anomaly.Conf.Spawn) do
		AddBirthPoint(Anomaly.Conf.Name, Anomaly.Conf.Map,  Spawn.PosX, Spawn.PosY)
	end
end
if not Anomaly.KickStart then
	--	Set to 'true' so it doesn't run again.
	Anomaly.KickStart = true
	--	Initiate all instances.
	for Num = 1, Anomaly.Conf.Instances, 1 do
		Anomaly.InstanceReset(Num)
	end
end

	--	Create birth points for players to spawn.
	Anomaly.CreateBirthPoint()
	--	Generate missing floors.
	Anomaly.GenerateFloors()
	--	Add map to the server.
	AddMap(Anomaly.Conf.Map, Anomaly.Conf.Name)
	--	
	Anomaly_Finish = Anomaly.Finish