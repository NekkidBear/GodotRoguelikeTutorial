extends Node2D

func _ready():
    var init_world = get_node("InitWorld")
    var pc_move = get_node("PCMove")
    init_world.connect("sprite_created", pc_move, "_on_InitWorld_sprite_created")