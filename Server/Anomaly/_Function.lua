if not Anomaly then
	Anomaly = {}
	Anomaly.Conf = {}
	Anomaly.Conf.Require = {}
	Anomaly.Conf.Text = {NPC = {}}
	Anomaly.Instance = {}
end

Anomaly.AvailableInstance = function()
	local Value = 0
	for a = 1, Anomaly.Conf.Instances, 1 do
		if Anomaly.Instance[a] == nil or not Anomaly.Instance[a].Initiate then
			Value = a
			break
		end
	end
	return Value
end
Anomaly.StartInstance = function(CopyID)
	Anomaly.Instance[CopyID] = {}
	Anomaly.Instance[CopyID].Init = false
	Anomaly.Instance[CopyID].Floor = 0
	Anomaly.Instance[CopyID].Time = 0
end

Anomaly.Register = function(Player, NPC)
	if not Anomaly.Conf.Enable then
		HelpInfo(Player, NPC, Anomaly.Conf.Text.NPC.NotEnabled:format(Anomaly.Conf.NameNPC, Anomaly.Conf.Name))
		return LUA_FALSE
	end
	local PlayerLevel = Lv(Player)
	if Anomaly.Conf.Require.MinLevel ~= 0 and PlayerLevel < Anomaly.Conf.Require.MinLevel then
		HelpInfo(Player, NPC, Anomaly.Conf.Text.NPC.AboveLevel:format(Anomaly.Conf.NameNPC, Anomaly.Conf.Require.MinLevel, Anomaly.Conf.Name))
		return LUA_FALSE
	end
	if Anomaly.Conf.Require.MaxLevel ~= 0 and PlayerLevel > Anomaly.Conf.Require.MaxLevel then
		HelpInfo(Player, NPC, Anomaly.Conf.Text.NPC.BelowLevel:format(Anomaly.Conf.NameNPC, Anomaly.Conf.Require.MaxLevel, Anomaly.Conf.Name))
		return LUA_FALSE
	end
	return LUA_TRUE
end