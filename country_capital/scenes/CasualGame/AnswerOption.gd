extends Control

signal option_selected

export var labelText = "A lonng long long capital name Kathmandu  Kathmandu Kathmandu name Kathmandu Kathmandu Kathmandu"
export var correct = true

onready var global_configs = get_node("/root/GlobalConfigurations")
onready var texture = $TextureRect
onready var label = get_node("TextureRect/VBoxContainer/Label")
onready var button = get_node("TextureRect/Button")

var btnPressedTexture = load("res://assets/sprites/option_bg_grey.png")
var normalTexture = load("res://assets/sprites/option_bg_white.png")
var tickTexture = load("res://assets/sprites/tick.png")
var crossTexture = load("res://assets/sprites/cross.png")

var scale = null

func _ready():
	scale = (global_configs.MAIN_MENU_SEL_WIDTH / texture.get_rect().size.x)
	print("scaling answer option texture by: ", scale)
	texture.set_scale(Vector2(scale , scale))
	texture.margin_left = (global_configs.SCREEN_WIDTH - texture.get_rect().size.x * scale) / 2
	
	_setText(labelText)



func _correctFeedback():
	print("correct")
	var tick = TextureRect.new()
	tick.set_texture(tickTexture)
	tick.name = "Tick"
	add_child(tick)	
	for c in get_children():
		if c.name == "Tick":
			$Tween.interpolate_property(c, "rect_scale", Vector2(0.4, 0.4) + c.get_scale(), c.get_scale(), 0.3, Tween.TRANS_CUBIC, Tween.EASE_OUT)
			$Tween.start()
			break
	
	
func _incorrectFeedback():
	print("incorrect")
	var cross = TextureRect.new()
	cross.set_texture(crossTexture)
	cross.name = "Cross"
	add_child(cross)
	for c in get_children():
		if c.name == "Cross":
			$Tween.interpolate_property(c, "rect_scale", Vector2(0.4, 0.4) + c.get_scale(), c.get_scale(), 0.3, Tween.TRANS_CUBIC, Tween.EASE_OUT)
			$Tween.start()
			break
			

func _setText(labelText):
	label.set_text(labelText)


func _on_Button_button_down():
	texture.set_texture(btnPressedTexture)
	emit_signal("option_selected", labelText)
	if correct:
		_correctFeedback()
	else:
		_incorrectFeedback()

func _on_Button_button_up():
	texture.set_texture(normalTexture)
