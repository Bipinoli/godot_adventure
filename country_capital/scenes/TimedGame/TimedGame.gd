extends Control


var gameManager = null

var _waiting_to_show_right_answer = false
var _correct_option = null
var option_selected = false

onready var global_configs = get_node("/root/GlobalConfigurations")
onready var scene_changer = get_node("/root/SceneChanger")
onready var game_timer = get_node("GameTimer")
onready var countDown = get_node("Background/TitleArea/TimeArea/CountDown")

func _ready():
	_applyTheme()
	_connectSignals()
	gameManager = load("res://scenes/Common/GameManager.gd").new()
	gameManager._init()
	_newQuestion()
	game_timer.start(30)
	
	

func _process(delta):
	var timeLeft = game_timer.get_time_left()
	var text = str(int(timeLeft))
	if text.length() < 2:
		text = "0" + text
	text = "0:" + text
	countDown.set_text(text)
	
	
	
func _notification(what):
	match what:
		MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
			print("go back from Timed Game --------------------------------------------")
			scene_changer.changeScene("res://scenes/MainScreen/MainMenu/MainMenu.tscn")
	
	
	
func _applyTheme():
	var optionsTexture = get_node("Background/VBoxContainer/OptionsArea")
	var titleTexture = get_node("Background/TitleArea")
	match global_configs.theme:
		"green":
			optionsTexture.set_texture(load(global_configs.RECT_GREEN))
			titleTexture.set_texture(load(global_configs.TITLE_GREEN))
			set_theme(load(global_configs.THEME_GREEN))
		"yellow":
			optionsTexture.set_texture(load(global_configs.RECT_YELLOW))
			titleTexture.set_texture(load(global_configs.TITLE_YELLOW))
			set_theme(load(global_configs.THEME_YELLOW))
		"blue":
			optionsTexture.set_texture(load(global_configs.RECT_BLUE))
			titleTexture.set_texture(load(global_configs.TITLE_BLUE))
			set_theme(load(global_configs.THEME_BLUE))
		"purple":
			optionsTexture.set_texture(load(global_configs.RECT_PURPLE))
			titleTexture.set_texture(load(global_configs.TITLE_PURPLE))
			set_theme(load(global_configs.THEME_PURPLE))
		"black":
			optionsTexture.set_texture(load(global_configs.RECT_BLACK))
			titleTexture.set_texture(load(global_configs.TITLE_BLACK))
			set_theme(load(global_configs.THEME_BLACK))
		"red":
			optionsTexture.set_texture(load(global_configs.RECT_RED))
			titleTexture.set_texture(load(global_configs.TITLE_RED))
			set_theme(load(global_configs.THEME_RED))
			
			
	
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



func _on_GameTimer_timeout():
	print("----  game over -----")
