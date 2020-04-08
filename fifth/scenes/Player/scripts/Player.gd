extends Node2D


export var move_speed := 700
export var _scale_screen_size := 1



func _move(direction, multiplier):
	var impulse = move_speed * multiplier
	var impulse_force = impulse * direction
	$RigidBody2D.apply_impulse(Vector2(), impulse_force)
	

func _on_SwipeDetector_swiped(direction, strength, time):
	print("direction: ", direction)
	print("strength: ", strength)
	print("time: ", time)
	var multiplier = _scale_screen_size * (strength / (1 + time)) / 100
	print("multiplier: ", multiplier)
	_move(direction, multiplier)
