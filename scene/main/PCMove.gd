extends Node2D

signal pc_moved(message)

const DungeonBoard := preload("res://scene/main/DungeonBoard.gd")
const Schedule := preload("res://scene/main/Schedule.gd")

const PC_ATTACK: String = "PCAttack"
const RELOAD_GAME: String = "ReloadGame"

var _ref_DungeonBoard: DungeonBoard
var _ref_Schedule: Schedule

var _new_ConvertCoord := preload("res://library/ConvertCoord.gd").new()
var _new_InputName := preload("res://library/InputName.gd").new()
var _new_GroupName := preload("res://library/GroupName.gd").new()

var _pc: Sprite2D
var _move_inputs: Array = [
	_new_InputName.MOVE_LEFT,
	_new_InputName.MOVE_RIGHT,
	_new_InputName.MOVE_UP,
	_new_InputName.MOVE_DOWN,
]


func _ready() -> void:
	set_process_unhandled_input(false)


func _unhandled_input(event: InputEvent) -> void:
	var source: Array = _new_ConvertCoord.vector_to_array(_pc.position)
	var target: Array

	if _is_move_input(event):
		target = _get_new_position(event, source)
		_try_move(target[0], target[1])
	elif _is_reload_input(event):
		get_node(RELOAD_GAME).reload()

func _is_reload_input(event):
	if event.is_action_pressed(_new_InputName.RELOAD):
		return true
	return false
	
func _on_InitWorld_sprite_created(new_sprite: Sprite2D) -> void:
	if new_sprite.is_in_group(_new_GroupName.PC):
		_pc = new_sprite
		set_process_unhandled_input(true)


func _on_Schedule_turn_started(current_sprite: Sprite2D) -> void:
	if current_sprite.is_in_group(_new_GroupName.PC):
		set_process_unhandled_input(true)
	# print("{0}: Start turn.".format([current_sprite.name]))


func _is_move_input(event: InputEvent) -> bool:
	for m in _move_inputs:
		if event.is_action_pressed(m):
			return true
	return false


func _try_move(x: int, y: int) -> void:
	if not _ref_DungeonBoard.is_inside_dungeon(x, y):
		emit_signal("pc_moved", "You cannot leave the map.")
	elif _ref_DungeonBoard.has_sprite(_new_GroupName.WALL, x, y):
		emit_signal("pc_moved", "You bumped into a wall.")
	elif _ref_DungeonBoard.has_sprite(_new_GroupName.DWARF, x, y):
		set_process_unhandled_input(false)
		get_node(PC_ATTACK).attack(_new_GroupName.DWARF, x, y)
	else:
		set_process_unhandled_input(false)
		_pc.position = _new_ConvertCoord.index_to_vector(x, y)
		_ref_Schedule.end_turn()


func _get_new_position(event: InputEvent, source: Array) -> Array:
	var x: int = source[0]
	var y: int = source[1]

	if event.is_action_pressed(_new_InputName.MOVE_LEFT):
		x -= 1
	elif event.is_action_pressed(_new_InputName.MOVE_RIGHT):
		x += 1
	elif event.is_action_pressed(_new_InputName.MOVE_UP):
		y -= 1
	elif event.is_action_pressed(_new_InputName.MOVE_DOWN):
		y += 1

	return [x, y]
