extends Control


onready var global_configs = get_node("/root/GlobalConfigurations")

func _ready():
	pass


func _update_theme(color):
	var theme = null
	var texture = null
	match color:
		"green":
			theme = load(global_configs.THEME_GREEN)
			texture = load(global_configs.RECT_GREEN)
		"blue":
			theme = load(global_configs.THEME_BLUE)
			texture = load(global_configs.RECT_BLUE)
		"yellow":
			theme = load(global_configs.THEME_YELLOW)
			texture = load(global_configs.RECT_YELLOW)
		"red":
			theme = load(global_configs.THEME_RED)
			texture = load(global_configs.RECT_RED)
		"black":
			theme = load(global_configs.THEME_BLACK)
			texture = load(global_configs.RECT_BLACK)
		"purple":
			theme = load(global_configs.THEME_PURPLE)
			texture = load(global_configs.RECT_PURPLE)
	print(texture)
	print(theme)
	set_theme(theme)
	$TextureRect.set_texture(texture)

func _on_ThemeSelection_btn1_pressed():
	_update_theme("blue")


func _on_ThemeSelection_btn2_pressed():
	_update_theme("green")
	

func _on_ThemeSelection_btn3_pressed():
	_update_theme("yellow")


func _on_ThemeSelection2_btn1_pressed():
	_update_theme("purple")


func _on_ThemeSelection2_btn2_pressed():
	_update_theme("black")


func _on_ThemeSelection2_btn3_pressed():
	_update_theme("red")
