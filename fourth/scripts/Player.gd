# script: Player.gd

extends Node2D

export var move_speed := 200

func _process(delta):
	if Input.is_action_pressed("ui_left"):
		move("left")
	elif Input.is_action_pressed("ui_right"):
		move("right")
	elif Input.is_action_pressed("ui_up"):
		move("up")
	elif Input.is_action_pressed("ui_down"):
		move("down")
		
		
func move(direction):
	match direction:
		"up":
			$RigidBody2D.set_linear_velocity(Vector2($RigidBody2D.get_linear_velocity().x, -move_speed))
		"down":
			$RigidBody2D.set_linear_velocity(Vector2($RigidBody2D.get_linear_velocity().x, move_speed))
		"left":
			$RigidBody2D.set_linear_velocity(Vector2(-move_speed, $RigidBody2D.get_linear_velocity().y))
		"right":
			$RigidBody2D.set_linear_velocity(Vector2(move_speed, $RigidBody2D.get_linear_velocity().y))
			
