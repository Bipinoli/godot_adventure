extends Control


signal menu_selected

onready var global_configs = get_node("/root/GlobalConfigurations")
onready var aboveTexture = get_node("BelowTexture/AboveTexture")
onready var belowTexture = get_node("BelowTexture")
onready var vboxContainer = get_node("BelowTexture/VBoxContainer")
onready var tween = get_node("Tween")

export var labelText = "CASUAL Mode"
export var highScore = 20
export var alternateStructure = false

var scale = null

func _ready():
	scale = (global_configs.MAIN_MENU_SEL_WIDTH / belowTexture.get_rect().size.x)
	print("scaling menu option by: ", scale)
	belowTexture.set_scale(Vector2(scale , scale))
	belowTexture.margin_left = (global_configs.SCREEN_WIDTH - belowTexture.get_rect().size.x * scale) / 2

	randomize()
	tween.interpolate_property(aboveTexture, "rect_scale", aboveTexture.get_scale(), Vector2(-0.3, 0) + aboveTexture.get_scale(), 1, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT, rand_range(0,1))
	tween.start()
	
	_setLabel(labelText)
	_setHighScore(highScore)
	if alternateStructure:
		_alternateStructure()
	


func _on_TextureButton_button_down():
	emit_signal("menu_selected", self.name)
#	if tween.is_active():
#		print("active tween")
#		return
#	print("no active tween")
	tween.interpolate_property(aboveTexture, "rect_scale", aboveTexture.get_scale(), Vector2(+0.3, 0) + aboveTexture.get_scale(), 0.1, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.start()


func _setLabel(labelText):
	get_node("BelowTexture/AboveTexture/Label").set_text(labelText)

func _setHighScore(highScore):
	get_node("BelowTexture/VBoxContainer/Score").set_text(str(highScore))

func _alternateStructure():
	aboveTexture.set_pivot_offset(Vector2(aboveTexture.get_rect().size.x, 0))
	var vBoxPosition = vboxContainer.get_position()
	var vBoxSize = vboxContainer.get_rect().size
	var parentSize = vboxContainer.get_parent().get_rect().size
	var pos = parentSize.x - vBoxPosition.x - vBoxSize.x 
	vboxContainer.set_position(Vector2(pos, vboxContainer.get_position().y))
