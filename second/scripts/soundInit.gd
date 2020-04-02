extends AudioStreamPlayer2D

func _process(delta):
	if not is_playing():
		_set_playing(true)
