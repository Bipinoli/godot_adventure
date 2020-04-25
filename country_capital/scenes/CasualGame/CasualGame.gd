extends Control


var gameManager = null

var _waiting_to_show_right_answer = false
var _correct_option = null
var option_selected = false
var country = null
var correctAns = 0
var wrongAns = 0


onready var global_configs = get_node("/root/GlobalConfigurations")
onready var scene_changer = get_node("/root/SceneChanger")
onready var dataPersistence = get_node("/root/DataPersistence")
onready var facebook_ad = get_node("/root/FacebookAd")


func _ready():
	_applyTheme()
	_connectSignals()
	gameManager = load("res://scenes/Common/GameManager.gd").new()
	gameManager._init()
	_newQuestion()
	
	
func _notification(what):
	match what:
		MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
			print("go back from Casual Game --------------------------------------------")
			_updateHighScore()
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
	country = question['country']
	
	if facebook_ad._shouldAdBeShown():
		facebook_ad._showAd()
	



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
		correctAns += 1
		$Timer.start(0.4)
	else:
		node._incorrectVisual()
		node._incorrectSound()
		_waiting_to_show_right_answer = true
		_correct_option = str(result['correct_option']+1)
		wrongAns += 1
		$Timer.start(0.4)
		
	

func _compareScore(r1, w1, r2, w2):
	if (r2+w2) > (r1+w1):
		return [r2, w2]
	elif (r1+w1) > (r2+w2):
		return [r1, w1]
	elif r1 >= r2:
		return [r1, w1]
	else:
		return [r2, w2]
	
	
func _updateHighScore():
	var prev = dataPersistence.getCasualHighScore()
	var highScore = _compareScore(prev[0], prev[1], correctAns, wrongAns)
	dataPersistence.saveCasualHighScore(highScore[0], highScore[1])



func _on_Timer_timeout():
	if _waiting_to_show_right_answer:
		var correctNode = get_node("Background/VBoxContainer/OptionsArea/VBoxContainer/Opt" + _correct_option)
		correctNode._correctVisual()
		_waiting_to_show_right_answer = false
		$Timer.start(1.2)
		return
	_newQuestion()


func _on_FlagButton_button_down():
	global_configs.detail_selected_country = country
	global_configs.detail_screen_routed_from_casual_game = true
	_updateHighScore()
	scene_changer.changeScene("res://scenes/LearningGame/DetailsScreen.tscn")








