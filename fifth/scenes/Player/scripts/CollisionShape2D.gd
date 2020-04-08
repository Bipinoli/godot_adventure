extends CollisionShape2D


func _ready():	
	var sprite = get_node("../Sprite")
	var scale = sprite.get_transform().get_scale()	
	var extents = Vector2(scale * sprite.get_rect().size/2 - Vector2(5,5))
	get_shape().set_extents(extents)
