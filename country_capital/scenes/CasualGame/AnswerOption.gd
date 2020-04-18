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
var rightSound = load("res://assets/audio/right.ogg")
var wrongSound = load("res://assets/audio/wrong.ogg")

var scale = null

func _ready():
	scale = (global_configs.MAIN_MENU_SEL_WIDTH / texture.get_rect().size.x)
	print("scaling answer option texture by: ", scale)
	texture.set_scale(Vector2(scale , scale))
	texture.margin_left = (global_configs.SCREEN_WIDTH - texture.get_rect().size.x * scale) / 2
	
	_setText(labelText)



func _correctVisual():
	var tick = TextureRect.new()
	tick.set_texture(tickTexture)
	tick.name = "Tick"
	add_child(tick)	
	for c in get_children():
		if c.name == "Tick":
			$Tween.interpolate_property(c, "rect_scale", Vector2(0.4, 0.4) + c.get_scale(), c.get_scale(), 0.3, Tween.TRANS_CUBIC, Tween.EASE_OUT)
			$Tween.start()
			break
			
	
func _incorrectVisual():
	var cross = TextureRect.new()
	cross.set_texture(crossTexture)
	cross.name = "Cross"
	add_child(cross)
	for c in get_children():
		if c.name == "Cross":
			$Tween.interpolate_property(c, "rect_scale", Vector2(0.4, 0.4) + c.get_scale(), c.get_scale(), 0.3, Tween.TRANS_CUBIC, Tween.EASE_OUT)
			$Tween.start()
			break		


func _correctSound():
	rightSound.set_loop(false)
	$AudioStreamPlayer.set_stream(rightSound)
	$AudioStreamPlayer.play()


func _incorrectSound():
	wrongSound.set_loop(false)
	$AudioStreamPlayer.set_stream(wrongSound)
	$AudioStreamPlayer.play()
	Input.vibrate_handheld(200)


func _setText(labelText):
	label.set_text(labelText)


func _on_Button_button_down():
	texture.set_texture(btnPressedTexture)
	emit_signal("option_selected", labelText)
	if correct:
		_correctVisual()
	else:
		_incorrectVisual()

func _on_Button_button_up():
	texture.set_texture(normalTexture)
