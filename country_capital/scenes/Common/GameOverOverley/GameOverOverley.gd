extends Control


signal overlay_finished


onready var global_configs = get_node("/root/GlobalConfigurations")
onready var colorRect = get_node("ColorRect")
onready var labelNode = get_node("ColorRect/VBoxContainer/Label")
onready var scoreNode = get_node("ColorRect/VBoxContainer/Score")
onready var timer = get_node("Timer")

func _ready():
	_applyTheme(global_configs.theme)
	timer.start()
	
	

func _setLabel(labelText):
	labelNode.set_text(labelText)
	

func _setScoreLabel(labelText):
	scoreNode.set_text(labelText)
	

func _applyTheme(theme):
	match theme:
		"green":
			set_theme(load(global_configs.THEME_GREEN))
		"yellow":
			set_theme(load(global_configs.THEME_YELLOW))
		"blue":
			set_theme(load(global_configs.THEME_BLUE))
		"purple":
			set_theme(load(global_configs.THEME_PURPLE))
		"black":
			set_theme(load(global_configs.THEME_BLACK))
		"red":
			set_theme(load(global_configs.THEME_RED))
	


func _on_Timer_timeout():
	emit_signal("overlay_finished")
