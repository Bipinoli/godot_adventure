extends Control


#export var test_title = "what a title it is just amazing in't it"
#export var test_description = "what a description it is just amazing and freaking marvelous isn't it what a wonderful. escription it is just amazing and freaking marvelous isn't it what a wonderful. escription it is just amazing and freaking marvelous isn't it what a wonderful."

onready var colorRect = get_node("ColorRect")
onready var titleNode = get_node("ColorRect/HBoxContainer/Title")
onready var descriptionNode = get_node("ColorRect/HBoxContainer/Description")


#func _ready():
#	_setup(test_title, test_description)
#
	
func _setup(title, description):
	print(" --- tosetup: ", title, " ", description)
	_setTitle(title)
	_setDescription(description)
	_adaptSize()


func _setTitle(title):
	titleNode.set_text(title)
	

func _setDescription(description):
	descriptionNode.set_text(description)


func _adaptSize():
	# if there are more than 10 characters it overflows
	var overflow_rows = titleNode.get_text().length() / 20
	overflow_rows = max(overflow_rows, len(descriptionNode.get_text())/30)
	var extraSpace = overflow_rows * 24
	var currentSize = colorRect.get_size()
	colorRect.set_size(Vector2(currentSize.x, currentSize.y + extraSpace))
	set_custom_minimum_size(Vector2(currentSize.x, currentSize.y + extraSpace))
