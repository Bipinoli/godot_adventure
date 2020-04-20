extends Control


onready var global_configs = get_node("/root/GlobalConfigurations")
onready var scene_changer = get_node("/root/SceneChanger")

func _ready():
	_connectSignals()
	_update_theme(global_configs.theme)
	

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		# quit the game
		get_tree().quit() 


func _connectSignals():
	get_node("TextureRect/MarginContainer/VBoxContainer/CasualMode").connect("menu_selected", self, "_menuSelected")
	get_node("TextureRect/MarginContainer/VBoxContainer/TimedMode").connect("menu_selected", self, "_menuSelected")
	get_node("TextureRect/MarginContainer/VBoxContainer/SurvivalMode").connect("menu_selected", self, "_menuSelected")
	get_node("TextureRect/MarginContainer/VBoxContainer/LearningMode").connect("menu_selected", self, "_menuSelected")
	get_node("TextureRect/MarginContainer/VBoxContainer/ThemeSelection").connect("btn_pressed", self, "_themeSelected")
	get_node("TextureRect/MarginContainer/VBoxContainer/ThemeSelection2").connect("btn_pressed", self, "_themeSelected")


func _menuSelected(name):
	print(name + " menu selected")
	match name:
		"CasualMode":
			scene_changer.changeScene("res://scenes/CasualGame/CasualGame.tscn")
		"LearningMode":
			scene_changer.changeScene("res://scenes/LearningGame/LearningGame.tscn")
		_:
			scene_changer.changeScene("res://scenes/CasualGame/CasualGame.tscn")
	

func _themeSelected(theme):
	print("theme selected: " + theme)
	_update_theme(theme)


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
	set_theme(theme)
	$TextureRect.set_texture(texture)
	global_configs.theme = color
