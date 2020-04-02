# script: touchScreenInit.gd

extends TouchScreenButton


func _ready():
	var zoomLevel = get_node("../camera").get_zoom()
	get_shape().set_extents(get_viewport_rect().size / 2 * zoomLevel)
	print(get_shape().get_extents())
