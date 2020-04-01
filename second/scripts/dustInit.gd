# script: dustGenInit.gd

extends Node


func _ready():
	var dustGen = get_node("../dust")
	var sprite = get_node("../sprite")
	var scale = sprite.get_transform().get_scale().y
	var sprite_disp_height = scale * sprite.get_rect().size.y / 2
	dustGen.set_position(Vector2(0, sprite_disp_height))
