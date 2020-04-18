extends TextureRect


export var country = "Nepal"

func _ready():
	var flag = _get_flag(country)
	_set_flag(flag)

func _get_flag(country):
	return load("res://data/flags/" + country + ".png")

func _set_flag(flag):
	print(flag)
	print(flag.get_size())
	set_texture(flag)
	set_size(flag.get_size())
	var offset = (get_parent().get_rect().size.x -  flag.get_width())/2
	set_position(Vector2(offset, get_position().y))
