extends Control


var question = {}
var gameManager = null

func _ready():
	_connectSignals()
	gameManager = load("res://scenes/CasualGame/GameManager.gd").new()
	gameManager._init()
	

func _process(delta):
	pass
#	print(get_node("Background/VBoxContainer/OptionsArea/VBoxContainer/Opt1").label.get_text())


func _updateView():
	# flag, country, options
	var flag = get_node("Background/VBoxContainer/FlagArea/FlagBorder/Flag")
	flag._set_flag(flag._get_flag_texture(question['flag']))
	get_node("Background/VBoxContainer/FlagArea/CountryName").set_text(question['country'])
	get_node("Background/VBoxContainer/OptionsArea/VBoxContainer/Opt2")._setText(question['option2'])
	get_node("Background/VBoxContainer/OptionsArea/VBoxContainer/Opt3")._setText(question['option3'])
	get_node("Background/VBoxContainer/OptionsArea/VBoxContainer/Opt4")._setText(question['option4'])
	get_node("Background/VBoxContainer/OptionsArea/VBoxContainer/Opt1")._setText(question['option1'])
	
	
	
func _connectSignals():
	var options = []	
	for i in range(4):
		var opt = "Opt" + str(i+1)
		var opt_node = get_node("Background/VBoxContainer/OptionsArea/VBoxContainer/" + opt)
		print(opt_node)
		opt_node.connect("option_selected", self, "_optionSelected")


func _optionSelected(text):
	print("user answered: " + text)
	question = gameManager._prepareQuestion()
	print(question)
	_updateView()
