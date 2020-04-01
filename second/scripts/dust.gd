extends Node2D


func _process(delta):
	if not $particle.is_emitting():
		queue_free()
