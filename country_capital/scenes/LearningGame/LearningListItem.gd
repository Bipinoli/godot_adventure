extends Control


signal listitem_clicked


onready var flag = get_node("ColorRect/Flag")
onready var country = get_node("ColorRect/Country")
onready var capital = get_node("ColorRect/Capital")

func _ready():
#	_setCountry("united arab emirates and historical")
	pass

func _setup(country_val, capital_val, flag_name):
	_setCountry(country_val)
	_setCapital(capital_val)
	_set_flag(_get_flag_texture(flag_name))

func _get_flag_texture(flag_name):
	return load("res://data/flags/" + flag_name + ".png")

func _set_flag(flag_texture):
	flag.set_texture(flag_texture)

func _setCountry(country_val):
	# roughly 15 chars fit in one line so lets scale the text down 
	# incase of overflow
	country.set_text(country_val)
	if len(country_val) > 15:
		var scale: float = (15.0 / len(country_val))
		print("--- country label overflow ----: ", country_val)
		print("--- scaling by: ", scale)
		country.set_scale(Vector2(scale, scale))
		country.set_size(Vector2(country.get_size().x/scale, country.get_size().y/scale))

func _setCapital(capital_val):
	capital.set_text(capital_val)
	

 
func _getCountry():
	return country.get_text()


func _on_TextureButton_button_down():
	$Timer.start(0.2)


func _on_TextureButton_button_up():
	# it is click if timer hasn't finish else it is a swipe
	if not $Timer.is_stopped():
		$Timer.stop()
		emit_signal("listitem_clicked", _getCountry())
#		print("click")
#	else:
#		print("swipe")