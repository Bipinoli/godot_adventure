# script: World.gd

extends Node

var happy = true


func _process(delta):
	if Input.is_action_just_pressed("touch"):
		happy = not happy
		$Timer.stop()
		$CharacterRig/AnimationPlayer.stop()
		if $AngrySound.playing:
			$AngrySound.stop()
		if $HappySound.playing:
			$HappySound.stop()
		Input.vibrate_handheld(300)
		print("happy: ", happy)
	if happy:
		happyState(delta)
	else:
		angryState(delta)



func happyState(delta):
	if not $CharacterRig/AnimationPlayer.is_playing() and $Timer.is_stopped():
		$CharacterRig/AnimationPlayer.play("happy")
		if not $HappySound.playing:
			$HappySound.play()
		$Timer.start()


func angryState(delta):
	if not $CharacterRig/AnimationPlayer.is_playing() and $Timer.is_stopped():
		$CharacterRig/AnimationPlayer.play("angry")
		if not $AngrySound.playing:
			$AngrySound.play()
		$Timer.start(2)
