extends Control


signal menu_selected

export var labelText = "LEARNING Mode"


func _ready():
	var global_configs = get_node("/root/GlobalConfigurations")
	var texture = get_node("Texture")
	var scale = (global_configs.MAIN_MENU_SEL_WIDTH / texture.get_rect().size.x)
	print("scaling button by: ", scale)
	texture.set_scale(Vector2(scale , scale))
	texture.margin_left = (global_configs.SCREEN_WIDTH - texture.get_rect().size.x * scale) / 2
	_setLabel(labelText)
	

func _setLabel(labelText):
	get_node("Texture/Label").set_text(labelText)


func _on_Texture_button_down():
	emit_signal("menu_selected", self.name)
