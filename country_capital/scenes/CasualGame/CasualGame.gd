extends Control


func _ready():
	_connectSignals()


func _connectSignals():
	var options = []	
	for i in range(4):
		var opt = "Opt" + str(i+1)
		var opt_node = get_node("Background/VBoxContainer/OptionsArea/VBoxContainer/" + opt)
		print(opt_node)
		opt_node.connect("option_selected", self, "_optionSelected")


func _optionSelected(text):
	print("user answered: " + text)
