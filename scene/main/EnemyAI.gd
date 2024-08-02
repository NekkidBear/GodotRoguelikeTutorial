extends Node


signal enemy_warned(message)

const Schedule := preload("res://scene/main/Schedule.gd")

var _ref_Schedule: Schedule

var _new_GroupName := preload("res://library/GroupName.gd").new()
var _new_ConvertCoord := preload("res://library/ConvertCoord.gd").new()

var _pc: Sprite2D

func _on_Schedule_turn_started(current_sprite: Sprite2D) -> void:
	if not current_sprite.is_in_group(_new_GroupName.DWARF):
		return
		
	if _pc_is_close(_pc, current_sprite):
		emit_signal("enemy_warned", "Urist McRogueliker is scared!")
	_ref_Schedule.end_turn()


func _pc_is_close(source: Sprite2D, target: Sprite2D) -> bool:
	if not source or not target:
		return false
		
	var source_pos: Array = _new_ConvertCoord.vector_to_array(source.global_position)
	var target_pos: Array = _new_ConvertCoord.vector_to_array(target.global_position)
	var delta_x: int = abs(source_pos[0] - target_pos[0]) as int
	var delta_y: int = abs(source_pos[1] - target_pos[1]) as int
	
	return delta_x + delta_y < 2


func _on_init_world_sprite_created(new_sprite: Sprite2D) -> void:
	if new_sprite.is_in_group(_new_GroupName.PC):
		_pc = new_sprite
