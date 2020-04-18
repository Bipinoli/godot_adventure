extends TextureRect


export var country = "Nepal"

func _ready():
	var flag = _get_flag_texture(country)
	_set_flag(flag)

func _get_flag_texture(flag_name):
	return load("res://data/flags/" + flag_name + ".png")

func _set_flag(flag):
	print(flag)
	print(flag.get_size())
	set_texture(flag)
	set_size(flag.get_size())
	var offset = (get_parent().get_rect().size.x -  flag.get_width())/2
	set_position(Vector2(offset, get_position().y))
