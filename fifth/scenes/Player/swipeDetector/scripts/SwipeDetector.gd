extends Node


signal swiped(direction, strength, time)
signal swipe_canceled(start_position)

onready var timer := $Timer
var swipe_start_position := Vector2()
var already_pressed := false

func _ready():
	timer.connect("timeout", self, "_on_Timer_timeout")

func _input(event):
	if not event is InputEventScreenTouch:
		return
	if event.is_pressed() and not already_pressed:
		already_pressed = true
		_start_detection(event.position)
	elif not timer.is_stopped():
		already_pressed = false
		_stop_detection(event.position)

func _start_detection(position):
#	print("start")
	swipe_start_position = position
	timer.start()
	
func _stop_detection(position):
#	print("stop")
	if timer.is_stopped():
		return
	var vector = (position - swipe_start_position)
	emit_signal("swiped", vector.normalized(), vector.length(), timer.wait_time - timer.time_left)
	timer.stop()


func _on_Timer_timeout():
#	print("timeout")
	already_pressed = false
	emit_signal("swipe_canceled", swipe_start_position)
