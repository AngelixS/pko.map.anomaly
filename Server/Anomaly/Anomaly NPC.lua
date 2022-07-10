
AnomalyNPC = function()
	InitTrigger()
	TriggerAction(1, JumpPage, 1)
	TriggerAction(1, NpcInfoReload, Anomaly.Conf.NameNPC, AnomalyNPC)
	Start(GetMultiTrigger(), 1)

	if not Anomaly.Conf.Enable then
		Talk(1, string.format(Anomaly.Message.NPC.NotEnabled, Anomaly.Conf.NameNPC, Anomaly.Conf.Name))
		Text(1, AdjustTextSpace('Leave', 36), CloseTalk)
		return
	end
	Talk(1, string.format(Anomaly.Message.NPC.MainTalk, Anomaly.Conf.NameNPC, Anomaly.Conf.Name))
	Text(1, AdjustTextSpace('Register', 36), Anomaly.Register)
	Text(1, AdjustTextSpace('Leave', 36), CloseTalk)
	
end