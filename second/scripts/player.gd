# script: player.gd

extends RigidBody2D


export var jump_velocity := 700

var jumped := 0
var wasGrounded := false
var raycast

func _ready():
	raycast = get_node("raycast")

func _process(delta):
	if inGround():
		if not wasGrounded:
			emitDust()
			wasGrounded = true
		if Input.is_action_just_pressed("ui_up"):
			jump()
			jumped = 1
	else:
		wasGrounded = false
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
	
func emitDust():
	var scale = $sprite.get_transform().get_scale().y
	var sprite_disp_height = scale * $sprite.get_rect().size.y / 2
	var impactPosition = $sprite.get_position() + Vector2(0,sprite_disp_height/2)
	var dust = $dustProvider.getDust(impactPosition)
	dust.get_child(0).set_emitting(true)	
	add_child(dust)
