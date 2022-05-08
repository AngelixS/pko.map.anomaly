	-- ***************************************************************************************************************************** --
	-- ************************************************ [Map] Tower Climb - Anomaly ************************************************ --
	-- **************************************************** Scripted by Angelix **************************************************** --
	-- ***************************************************************************************************************************** --
	-- ************************************************ Main Configuration Settings ************************************************ --
	-- ***************************************************************************************************************************** --
	Anomaly.Conf.Enable = false									--	Enable/disable the whole map script.
	Anomaly.Conf.Name = 'Anomaly Tower'							--	Public name of the map, shown everywhere.
	Anomaly.Conf.Map = 'Anomaly'								--	Private name of the map, used for internal purposes.
	Anomaly.Conf.Instances = 5									--	Number of map copies available at a single time.
	Anomaly.Conf.NameNPC = 'Akeno'								--	Name of the NPC where registration is done.
	-- ***************************************************************************************************************************** --
	-- ************************************************ Entry Requirement Variables ************************************************ --
	-- ***************************************************************************************************************************** --
	Anomaly.Conf.Require.MinLevel = 0							--	Minimum level allowed to enter the map, set to "0" if not needed.
	Anomaly.Conf.Require.MaxLevel = 0							--	Maximum level allowed to enter the map, set to "0" if not needed.
	-- ***************************************************************************************************************************** --
	-- ************************************************ Main Messages Configuration ************************************************ --
	-- ***************************************************************************************************************************** --
	Anomaly.Conf.Text.NPC.MainTalk = '%s: We found [%s] and it\'s mysterious connection to another realm and endless energy is coming through.'
	Anomaly.Conf.Text.NPC.NotEnabled = '%s: The strange energy coming through is not stable enough, so entrance to [%s] is prohibited at this moment.'
	Anomaly.Conf.Text.NPC.AboveLevel = '%s: You need to be above level %d to enter [%s].'
	Anomaly.Conf.Text.NPC.BelowLevel = '%s: You need to be below level %d to enter [%s].'
	