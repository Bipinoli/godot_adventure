# script: player.gd

extends RigidBody2D


export var jump_velocity := 700

var jumped := 0
var raycast

func _ready():
	raycast = get_node("raycast")

func _process(delta):
	if inGround():
		if Input.is_action_just_pressed("ui_up"):
			jump()
			jumped = 1
	else:
		if jumped == 1 and Input.is_action_just_pressed("ui_up"):
			jump()
			jumped += 1

func jump():
	set_linear_velocity(Vector2(get_linear_velocity().x, -jump_velocity))
	
func inGround():
	var collider = raycast.get_collider()
	if collider:
		if collider.name == "ground":
			return true
	return false
