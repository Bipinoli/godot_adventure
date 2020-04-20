extends Control


signal listitem_clicked


onready var flag = get_node("ColorRect/Flag")
onready var country = get_node("ColorRect/VBoxContainer/Country")
onready var capital = get_node("ColorRect/VBoxContainer/Capital")


func _setup(country_val, capital_val, flag_name):
	_setCountry(country_val)
	_setCapital(capital_val)
	_set_flag(_get_flag_texture(flag_name))

func _get_flag_texture(flag_name):
	return load("res://data/flags/" + flag_name + ".png")

func _set_flag(flag_texture):
	flag.set_texture(flag_texture)

func _setCountry(country_val):
	print("country: ", country_val)
	print("name: ", self.name)
	country.set_text(country_val)

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
