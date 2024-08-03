extends Node


signal pc_attacked(message)

const DungeonBoard := preload("res://scene/main/DungeonBoard.gd")
const Schedule := preload("res://scene/main/Schedule.gd")
const RemoveObject := preload("res://scene/main/RemoveObject.gd")

var _ref_DungeonBoard: DungeonBoard
var _ref_Schedule: Schedule
var _ref_RemoveObject: RemoveObject

func attack(group_name: String, x: int, y: int) -> void:
	# Ensure references are set
	assert(_ref_DungeonBoard != null, "DungeonBoard reference not set")
	assert(_ref_Schedule != null, "Schedule reference not set")
	assert(_ref_RemoveObject != null, "RemoveObject reference not set")
	
	if not _ref_DungeonBoard.has_sprite(group_name, x, y):
		return
	_ref_RemoveObject.remove(group_name, x, y)
	_ref_Schedule.end_turn()
	emit_signal("pc_attacked", "You kill Urist McRogueliker! :(")
