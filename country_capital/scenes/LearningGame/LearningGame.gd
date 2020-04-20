extends Control


onready var global_configs = get_node("/root/GlobalConfigurations")
onready var scene_changer = get_node("/root/SceneChanger")

#export var test_theme = "green"


func _ready():
#	global_configs.theme = test_theme
	_applyTheme()


func _notification(what):
	match what:
		MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
			print("go back --------------------------------------------")
			scene_changer.changeScene("res://scenes/MainScreen/MainMenu/MainMenu.tscn")
	



func _applyTheme():
	var colorRect = get_node("ColorRect")
	var titleTexture = get_node("ColorRect/TitleTexture")
	match global_configs.theme:
		"green":
			colorRect.color = Color(global_configs.COLOR_GREEN)
			titleTexture.set_texture(load(global_configs.LEARN_TITLE_GREEN))
			set_theme(load(global_configs.THEME_GREEN))
		"yellow":
			colorRect.color = Color(global_configs.COLOR_YELLOW)
			titleTexture.set_texture(load(global_configs.LEARN_TITLE_YELLOW))
			set_theme(load(global_configs.THEME_YELLOW))
		"blue":
			colorRect.color = Color(global_configs.COLOR_BLUE)
			titleTexture.set_texture(load(global_configs.LEARN_TITLE_BLUE))
			set_theme(load(global_configs.THEME_BLUE))
		"purple":
			colorRect.color = Color(global_configs.COLOR_PURPLE)
			titleTexture.set_texture(load(global_configs.LEARN_TITLE_PURPLE))
			set_theme(load(global_configs.THEME_PURPLE))
		"black":
			colorRect.color = Color(global_configs.COLOR_BLACK)
			titleTexture.set_texture(load(global_configs.LEARN_TITLE_BLACK))
			set_theme(load(global_configs.THEME_BLACK))
		"red":
			colorRect.color = Color(global_configs.COLOR_RED)
			titleTexture.set_texture(load(global_configs.LEARN_TITLE_RED))
			set_theme(load(global_configs.THEME_RED))
