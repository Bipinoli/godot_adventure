extends Control

signal option_selected

export var labelText = "A lonng long long capital name Kathmandu  Kathmandu Kathmandu name Kathmandu Kathmandu Kathmandu"

onready var global_configs = get_node("/root/GlobalConfigurations")
onready var texture = $TextureRect
onready var label = get_node("TextureRect/VBoxContainer/Label")

var scale = null


func _ready():
	scale = (global_configs.MAIN_MENU_SEL_WIDTH / texture.get_rect().size.x)
	print("scaling answer option texture by: ", scale)
	texture.set_scale(Vector2(scale , scale))
	texture.margin_left = (global_configs.SCREEN_WIDTH - texture.get_rect().size.x * scale) / 2
	
	_setText(labelText)


func _setText(labelText):
	label.set_text(labelText)


func _on_Button_button_down():
	emit_signal("option_selected", labelText)
