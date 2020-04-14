extends Control

var textureRectScaled = false

func _ready():
	var global_configs = get_node("/root/GlobalConfigurations")
	
	var centerContainer = get_node("CenterContainer")
	var scale = global_configs.SCREEN_WIDTH / centerContainer.get_rect().size.x
	print("scaling center container by ", scale)
	centerContainer.set_scale(Vector2(scale, scale))
	

	
func _process(delta):
	if not textureRectScaled:
		# for some reason it is not working in _ready()
		var textureRect = get_node("CenterContainer/TextureRect")
		var scale = get_node("/root/GlobalConfigurations").MAIN_MENU_SEL_WIDTH / textureRect.get_rect().size.x
		textureRect.set_pivot_offset(textureRect.get_rect().size / 2)
		textureRect.set_scale(Vector2(min(scale + 0.1, 1), min(scale + 0.1, 1)))
		textureRectScaled = true
