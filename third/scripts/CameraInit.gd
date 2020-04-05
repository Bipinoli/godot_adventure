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
