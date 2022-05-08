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
	return LUA_TRUE
end