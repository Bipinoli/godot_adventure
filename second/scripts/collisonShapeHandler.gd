# script: collisonShapeHandler.gd

extends Node


func _ready():	
	var sprite = get_node("../sprite")
	var collisonShape = get_node("../collisonShape")
	var scale = sprite.get_transform().get_scale()	
	var extents = Vector2(scale * sprite.get_rect().size/2 - Vector2(5,5))
	collisonShape.get_shape().set_extents(extents)
