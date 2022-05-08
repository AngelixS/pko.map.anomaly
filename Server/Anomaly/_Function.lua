if not Anomaly then
	Anomaly = {}
	Anomaly.Conf = {}
	Anomaly.Conf.Require = {}
	Anomaly.Conf.Text = {NPC = {}}
	Anomaly.Lobby = {}
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