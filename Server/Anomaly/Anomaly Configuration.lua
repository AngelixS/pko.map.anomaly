	-- ***************************************************************************************************************************** --
	-- ************************************************ [Map] Tower Climb - Anomaly ************************************************ --
	-- **************************************************** Scripted by Angelix **************************************************** --
	-- ***************************************************************************************************************************** --
	-- ************************************************ Main Configuration Settings ************************************************ --
	-- ***************************************************************************************************************************** --
	Anomaly.Conf.Enable = true									--	Enable/disable the whole map script.
	Anomaly.Conf.Test = true									--	Place script into test mode.
	Anomaly.Conf.Name = 'Anomaly Tower'							--	Public name of the map, shown everywhere.
	Anomaly.Conf.Map = 'Anomaly'								--	Private name of the map, used for internal purposes.
	Anomaly.Conf.Instances = 5									--	Number of map copies available at a single time.
	Anomaly.Conf.NameNPC = 'Manager'								--	Name of the NPC where registration is done.
	Anomaly.Conf.Players = 1									--	Amount of players that can enter.
	Anomaly.Conf.FloorLimit = 10								--	Maximum floor limit.
	Anomaly.Conf.Cache = 'Anomaly/Cache/'						--	Foler where player data will be stored.
	Anomaly.Conf.CacheExt = '.db'
	Anomaly.Conf.FloorCache = 'Floor Configuration'
	-- ***************************************************************************************************************************** --
	-- ************************************************ Entry Requirement Variables ************************************************ --
	-- ***************************************************************************************************************************** --
	Anomaly.Conf.Require.MinLevel = 0							--	Minimum level allowed to enter the map, set to "0" if not needed.
	Anomaly.Conf.Require.MaxLevel = 0							--	Maximum level allowed to enter the map, set to "0" if not needed.
	-- ***************************************************************************************************************************** --
	-- ************************************************ Anomaly Floor Configuration ************************************************ --
	-- ***************************************************************************************************************************** --
	Anomaly.Conf.Attribute.Normal = 0.010						--	Attribute multiplier for monsters in regular floors.
	Anomaly.Conf.Attribute.Medium = 0.025						--	Attribute multiplier for monsters in miniboss floors. Adds to "Normal".
	Anomaly.Conf.Attribute.Final = 0.050						--	Attribute multiplier for monsters in boss floors. "Adds to "Normal".
	-- ***************************************************************************************************************************** --
	-- ******************************************** Anomaly Player/Monster Birth Points ******************************************** --
	-- ***************************************************************************************************************************** --
	Anomaly.Conf.Spawn = {
		{PosX = 0030, PosY = 0030}
						}
	Anomaly.Conf.MonsterSpawn.PosX = {Min = 0019, Max = 0042}
	Anomaly.Conf.MonsterSpawn.PosY = {Min = 0019, Max = 0042}

	-- ***************************************************************************************************************************** --
	-- ************************************************ Main Messages Configuration ************************************************ --
	-- ***************************************************************************************************************************** --
	Anomaly.Message.NPC.MainTalk = '%s: We found [%s] and it\'s mysterious connection to another realm and endless energy is coming through.'
	Anomaly.Message.NPC.NotEnabled = '%s: The strange energy coming through is not stable enough, so entrance to [%s] is prohibited at this moment.'
	Anomaly.Message.NPC.AboveLevel = '%s: You need to be above level %d to enter [%s].'
	Anomaly.Message.NPC.BelowLevel = '%s: You need to be below level %d to enter [%s].'
    Anomaly.Message.NPC.NotSolo = 'Cannot participate in [%s] while being in a party.'
    Anomaly.Message.NPC.NotTeam = 'Cannot participate in [%s] while your party has less than %d members.'
    Anomaly.Message.NPC.OnyLeader = 'Only the team leader can register for [%s].'
    Anomaly.Message.NPC.NotQualify = 'Someone in the party is not qualified to enter [%s].'
	Anomaly.Message.NPC.NoFreeInstance = 'Cannot participate in [%s] at this time, there\'s no available instances right now.'
    Anomaly.Message.NPC.FloorLimit = '%s: Cannot participate in [%s] since you\'ve reached the highest floor available.'