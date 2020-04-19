extends Control


var gameManager = null

var _waiting_to_show_right_answer = false
var _correct_option = null
var option_selected = false

func _ready():
	_connectSignals()
	gameManager = load("res://scenes/CasualGame/GameManager.gd").new()
	gameManager._init()
	_newQuestion()
	
func _newQuestion():
	var q = gameManager._prepareQuestion()
	var question = q['question']
	var score = q['score']
	_updateView(question, score)
	option_selected = false

func _updateView(question, score):
	var flag = get_node("Background/VBoxContainer/FlagArea/FlagBorder/Flag")
	flag._set_flag(flag._get_flag_texture(question['flag']))
	get_node("Background/VBoxContainer/FlagArea/CountryName").set_text(question['country'])
	for i in range(1,5):
		var option = get_node("Background/VBoxContainer/OptionsArea/VBoxContainer/Opt" + str(i))
		option._removeCorrectIncorrectVisual()
		option._setText(question['option'+str(i)])
	get_node("Background/TitleArea/VBoxContainer/Score").set_text(str(score['correct']) + "/" + str(score['total']))
	
	
func _updateScore(score):
	get_node("Background/TitleArea/VBoxContainer/Score").set_text(str(score['correct']) + "/" + str(score['total']))
	
	
func _connectSignals():
	var options = []	
	for i in range(4):
		var opt = "Opt" + str(i+1)
		var opt_node = get_node("Background/VBoxContainer/OptionsArea/VBoxContainer/" + opt)
		print(opt_node)
		opt_node.connect("option_selected", self, "_optionSelected")


func _optionSelected(node, text):
	if option_selected: 
		return 
	option_selected = true
	var result = gameManager._on_user_answer(text)
	print(result)
	_updateScore(result['score'])
	if result['correct']:
		node._correctVisual()
		node._correctSound()
		$Timer.start(0.4)
	else:
		node._incorrectVisual()
		node._incorrectSound()
		_waiting_to_show_right_answer = true
		_correct_option = str(result['correct_option']+1)
		$Timer.start(0.4)
		
	
	




func _on_Timer_timeout():
	if _waiting_to_show_right_answer:
		var correctNode = get_node("Background/VBoxContainer/OptionsArea/VBoxContainer/Opt" + _correct_option)
		correctNode._correctVisual()
		_waiting_to_show_right_answer = false
		$Timer.start(1.2)
		return
	_newQuestion()
