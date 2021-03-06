dofile(GetResPath("Anomaly/Anomaly Function.lua"))

function config(map)
	MapCanSavePos(map, 0)
	MapCanPK(map, 0)
	MapCopyNum(map, Anomaly.Conf.Instances)
	SingleMapCopyPlyNum(map, 1)
	MapCanTeam(map, 0)
	MapType(map, 4)
end
function get_map_entry_pos_Anomaly()
	return 0, 0
end
function init_entry(map)
end
function after_enter_Anomaly(Player, MapCopy)
	Anomaly.AfterEnter(Player, MapCopy, GetMapCopyID2(MapCopy))
end
function before_leave_Anomaly(Player, MapCopy)
	Anomaly.BeforeLeave(Player, MapCopy, GetMapCopyID2(MapCopy))
end
function map_run_Anomaly(Map)
end
function map_copy_run_Anomaly(MapCopy)
	Anomaly.MapCopyRun(MapCopy, GetMapCopyID2(MapCopy))
end
function map_copy_close_Anomaly(MapCopy)
	ClearAllSubMapMonster(MapCopy)
	ClearAllSubMapCha(MapCopy)
end