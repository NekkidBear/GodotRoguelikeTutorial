extends Label


var _new_GroupName := preload("res://library/GroupName.gd").new()

# Called when the node enters the scene tree for the first time.
func _ready():
	text = "Press Space to start game."


func _on_Schedule_turn_ended(current_sprite: Sprite2D) -> void:
	if current_sprite.is_in_group(_new_GroupName.PC):
		text = ""


func _on_EnemyAI_enemy_warned(message: String) -> void:
	text = message


func _on_PCMove_pc_moved(message: String) -> void:
	text = message


func _on_PCAttack_pc_attacked(message: String) -> void:
	text = message
