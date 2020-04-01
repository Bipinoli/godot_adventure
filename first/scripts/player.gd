extends RigidBody2D


export var move_speed := 200
export var jump_force := 200
export var extra_gravity := 300
export var move_acceleration := 7
export var air_move_speed := 50
export var air_acceleration := 2

var current_speed = Vector2(0,0)
var raycast_down = null
var jumped = 0

var ORIENTATION_PREV = null
var ORIENTATION = null
var ORIENTATION_NEXT = "right"

var STATE_PREV = null
var STATE = null
var STATE_NEXT = "air"

var btn_group = null
var scaled = 1

func _ready():
	set_applied_force(Vector2(0, extra_gravity))
	raycast_down = get_node("RayDown")
	var camera = get_node("Camera2D")
	scaled = 400/get_viewport_rect().size.y
	camera.set_zoom(Vector2(scaled, scaled))
	btn_group = get_node("../btns")
	print(btn_group.name)

func _process(delta):
	STATE_PREV = STATE
	STATE = STATE_NEXT
	
	ORIENTATION_PREV = ORIENTATION
	ORIENTATION = ORIENTATION_NEXT
	
	
	if STATE == "air":
		air_state(delta)
	elif STATE == "ground":
		ground_state(delta)

	print(get_position())
	btn_group.set_position(Vector2(get_position().x - 150, get_position().y - 150))



func ground_state(delta):
	if Input.is_action_pressed("left_action"):
		move(-move_speed, move_acceleration, delta)
		ORIENTATION_NEXT = "left"
	elif Input.is_action_pressed("right_action"):
		move(move_speed, move_acceleration, delta)
		ORIENTATION_NEXT = "right"
		
	handle_orientation()
	
	if is_grounded():
		if Input.is_action_just_pressed("ui_up"):
			jump(jump_force)
			jumped = 1
	else:
		STATE_NEXT = "air"
	
	
func air_state(delta):
	if Input.is_action_pressed("left_action"):
		move(-air_move_speed, air_acceleration, delta)
		ORIENTATION_NEXT = "left"
	elif Input.is_action_pressed("right_action"):
		move(air_move_speed, air_acceleration, delta)
		ORIENTATION_NEXT = "right"
		
	handle_orientation()
		
	if Input.is_action_just_pressed("ui_up") and jumped == 1:
		jump(jump_force)
		jumped = 2
		
	if is_grounded():
		STATE_NEXT = "ground"


func handle_orientation():
	if (ORIENTATION == "left" and ORIENTATION_NEXT == "right") or (ORIENTATION == "right" and ORIENTATION_NEXT == "left"):
		print("rotate")
		
		

func move(speed, acc, delta):
	current_speed.x = lerp(current_speed.x, speed, acc * delta)
	set_linear_velocity(Vector2(current_speed.x, get_linear_velocity().y))

func jump(force):
	set_axis_velocity(Vector2(0, -force))
	
func is_grounded():
	if raycast_down.is_colliding():
		return true
	else:
		return false
