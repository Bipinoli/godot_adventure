extends Control

var textureRectScaled = false

onready var aboveTexture = get_node("BelowTexture/AboveTexture")
onready var tween = get_node("Tween")


func _ready():
	print("anim menu sel ready")
	var global_configs = get_node("/root/GlobalConfigurations")

	var belowTexture = get_node("BelowTexture")
	var scale = (global_configs.MAIN_MENU_SEL_WIDTH / belowTexture.get_rect().size.x)
	print("scaling menu option by: ", scale)
	belowTexture.set_scale(Vector2(scale , scale))
	belowTexture.margin_left = (global_configs.SCREEN_WIDTH - belowTexture.get_rect().size.x * scale) / 2

	tween.interpolate_property(aboveTexture, "rect_scale", aboveTexture.get_scale(), Vector2(-0.3, 0) + aboveTexture.get_scale(), 1, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT, rand_range(0,1))
	tween.start()

func _on_TextureButton_button_down():
	tween.interpolate_property(aboveTexture, "rect_scale", aboveTexture.get_scale(), Vector2(+0.3, 0) + aboveTexture.get_scale(), 0.1, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.start()

func _on_TextureButton_button_up():
	tween.interpolate_property(aboveTexture, "rect_scale", aboveTexture.get_scale(), Vector2(-0.3, 0) + aboveTexture.get_scale(), 1, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.start()
