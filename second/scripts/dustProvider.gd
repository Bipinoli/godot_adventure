extends Node 

var Dust =  preload("res://scenes/dust.tscn")


func getDust(position):
	print("get dust")
	var dust = Dust.instance()
	dust.set_position(position)
	dust.get_child(0).set_one_shot(true)
	return dust
