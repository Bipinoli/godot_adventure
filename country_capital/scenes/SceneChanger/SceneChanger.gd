extends Node


signal scene_changed

onready var animationPlayer = $AnimationPlayer


func changeScene(path, delay=0):
	get_parent().call_deferred("move_child", self, get_parent().get_child_count()-1)
#	get_parent().move_child(self, get_parent().get_child_count()-1)
#	yield(get_tree().create_timer(delay), "timeout")
#	animationPlayer.play("TransitionAnim")
#	yield(animationPlayer, "animation_finished")
	assert(get_tree().change_scene(path) == OK)
#	animationPlayer.play_backwards("TransitionAnim")
#	yield(animationPlayer, "animation_finished")
	emit_signal("scene_changed")
#	get_parent().move_child(self, 0)
	get_parent().call_deferred("move_child", self, 0)
