# script: World.gd

extends Node


func _process(delta):
	if not $CharacterRig/AnimationPlayer.is_playing() and $Timer.is_stopped():
		$CharacterRig/AnimationPlayer.play("happy")
		if not $Sound.playing:
			$Sound.play()
		$Timer.start()
