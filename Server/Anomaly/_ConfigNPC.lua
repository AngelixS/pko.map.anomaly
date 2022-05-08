
AnomalyNPC = function()
	InitTrigger()
	TriggerAction(1, JumpPage, 1)
	TriggerAction(1, NpcInfoReload, Anomaly.Conf.NameNPC, AnomalyNPC)
	Start(GetMultiTrigger(), 1)

	if not Anomaly.Conf.Enable then
		Talk(1, string.format(Anomaly.Conf.Text.NPC.NotEnabled, Anomaly.Conf.NameNPC))
		Text(1, AdjustTextSpace('Leave', 36), CloseTalk)
		return
	end
	Talk(1, string.format(Anomaly.Conf.Text.NPC.MainTalk, Anomaly.Conf.NameNPC, Anomaly.Conf.Name))
	Text(1, AdjustTextSpace('Leave', 36), CloseTalk)
	
end