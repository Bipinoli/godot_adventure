extends Control

onready var global_configs = get_node("/root/GlobalConfigurations")
onready var texture = get_node("TextureRect")

export var type1 = true

func _ready():
	if type1:
		_structure_as_type1()
	else:
		_structure_as_type2()


func _structure_as_type1():
	texture.set_texture(load(global_configs.THEME_SEL_1))
	var scale = (global_configs.THEME_SEL_WIDTH / texture.get_rect().size.x)
	print("scaling button by: ", scale)
	texture.set_scale(Vector2(scale , scale))
	texture.margin_left = (global_configs.SCREEN_WIDTH - global_configs.MAIN_MENU_SEL_WIDTH) / 2
	
func _structure_as_type2():
	texture.set_texture(load(global_configs.THEME_SEL_2))
	var scale = (global_configs.THEME_SEL_WIDTH / texture.get_rect().size.x)
	print("scaling button by: ", scale)
	texture.set_scale(Vector2(scale , scale))
	var margin = (global_configs.SCREEN_WIDTH - global_configs.MAIN_MENU_SEL_WIDTH) / 2
	texture.set_position(Vector2(global_configs.SCREEN_WIDTH - global_configs.THEME_SEL_WIDTH - margin, 0))
	

func _on_Button1_button_down():
	print("button 1")


func _on_Button2_button_down():
	print("button 2")


func _on_Button3_button_down():
	print("button 3")
