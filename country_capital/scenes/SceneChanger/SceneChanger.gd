extends Node


signal scene_changed

onready var animationPlayer = $AnimationPlayer


func _ready():
	print("SceneChanger ready!")


func changeScene(path, delay=0):
	print("change Scene called with path: ", path)
	get_parent().call_deferred("move_child", self, get_parent().get_child_count()-1)
#	get_parent().move_child(self, get_parent().get_child_count()-1)
#	yield(get_tree().create_timer(delay), "timeout")
#	animationPlayer.play("TransitionAnim")
#	yield(animationPlayer, "animation_finished")
	var scene_change_result = get_tree().change_scene(path)
	print("--- scene change result: ", scene_change_result)
	assert(scene_change_result == OK)
#	animationPlayer.play_backwards("TransitionAnim")
#	yield(animationPlayer, "animation_finished")
	emit_signal("scene_changed")
#	get_parent().move_child(self, 0)
	get_parent().call_deferred("move_child", self, 0)
