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
	
	var scale = 1
	
	if flag.get_width() > get_parent().get_rect().size.x:
		print(" too wide ------")
		scale = (get_parent().get_rect().size.x - 10)/ flag.get_width() 
		print("scale border by: ", scale)
		set_scale(Vector2(scale, scale))
	elif flag.get_height() < get_parent().get_rect().size.y:
		print(" too tall -------")
		scale = flag.get_height() / (get_parent().get_rect().size.y - 10)
		print("scale border by: ", scale)
		set_scale(Vector2(scale, scale))
		
	var offset_x = (get_parent().get_rect().size.x - flag.get_width()*scale)/2
	var offset_y = (get_parent().get_rect().size.y - flag.get_height()*scale)/2
	print("offset: ", offset_x, " ", offset_y)
	set_position(Vector2(offset_x, offset_y))
