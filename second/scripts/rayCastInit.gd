extends Node

func _ready():
	var raycast = get_node("../raycast")
	var sprite = get_node("../sprite")
	var scale = sprite.get_transform().get_scale().y
	var castLength = scale * sprite.get_rect().size.y / 2
	raycast.set_cast_to(Vector2(0, castLength))
	raycast.enabled = true
	print("raycast length: ", castLength)
