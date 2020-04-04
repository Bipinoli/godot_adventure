# script: player.gd

extends RigidBody2D


export var jump_velocity := 700

signal camera_shake
signal camera_shake_hard

var jumped := 2
var wasGrounded := false
var raycast

func _ready():
	raycast = get_node("raycast")
	self.connect("camera_shake", get_node("../camera"), "_on_camera_shake")
	self.connect("camera_shake_hard", get_node("../camera"), "_on_camera_shake_hard")
	

func _process(delta):
	if inGround():
		if not wasGrounded:
			impactSound()
			emitDust()
			if jumped == 2:
				emit_signal("camera_shake_hard")
			else:
				emit_signal("camera_shake")
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
	var offset = scale * $sprite.get_rect().size.y / 2
	var impactPosition = $sprite.get_position() + Vector2(0,offset)
	var dust = $dustProvider.getDust(impactPosition)
	dust.get_child(0).set_emitting(true)	
	add_child(dust)
	
func impactSound():
	$sound.play()
