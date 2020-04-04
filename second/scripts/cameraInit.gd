# script: cameraInit.gd

extends Camera2D


export var DEFAULT_SCREEN_HEIGHT := 600
export var DEFAULT_SCREEN_WIDTH := 1024


func _ready():
	# scale down screen width and height keeping the aspect ratio
	var vw = get_viewport_rect().size.x 
	var zoom = DEFAULT_SCREEN_WIDTH / vw 
	set_zoom(Vector2(zoom, zoom))
	print("camera zoom: ", get_zoom())


func _on_camera_shake():
	$tween.interpolate_property(self, "zoom", get_zoom()-Vector2(0.2,0.2), get_zoom(), 0.1, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
	$tween.start()
	
func _on_camera_shake_hard():
	$tween.interpolate_property(self, "zoom", get_zoom()-Vector2(0.3,0.3), get_zoom(), 0.1, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
	$tween.start()
	$tween.interpolate_property(self, "rotation", deg2rad(2), get_rotation(), 0.1, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
	$tween.start()
