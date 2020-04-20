extends Control


onready var global_configs = get_node("/root/GlobalConfigurations")
onready var scene_changer = get_node("/root/SceneChanger")
onready var countryList = get_node("ColorRect/ScrollContainer/VBoxContainer")

var gameManager = null

func _ready():
	_applyTheme()
	gameManager = load("res://scenes/LearningGame/LearningGameManager.gd").new()
	gameManager._init()
	_updateView("Asia")


func _updateView(continent=null):
	var countries = gameManager._retrieveCountries(continent)
	for c in countryList.get_children():
		countryList.call_deferred("remove_child", c)
		c.queue_free()
	for c in countries:
		var listItem = load("res://scenes/LearningGame/LearningListItem.tscn").instance()
		listItem.rect_min_size.y = 100
		countryList.call_deferred("add_child", listItem)
		listItem.call_deferred("_setup", c['country'], c['capital'], c['flag'])
		listItem.call_deferred("connect", "listitem_clicked", self, "_listItemSelected")
	
	
func _listItemSelected(country):
	print("-- selected: ", country)
	

func _notification(what):
	match what:
		MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
			print("go back --------------------------------------------")
			scene_changer.changeScene("res://scenes/MainScreen/MainMenu/MainMenu.tscn")
	

func _applyTheme():
	var colorRect = get_node("ColorRect")
	var titleTexture = get_node("ColorRect/TitleTexture")
	match global_configs.theme:
		"green":
			colorRect.color = Color(global_configs.COLOR_GREEN)
			titleTexture.set_texture(load(global_configs.LEARN_TITLE_GREEN))
			set_theme(load(global_configs.THEME_GREEN))
		"yellow":
			colorRect.color = Color(global_configs.COLOR_YELLOW)
			titleTexture.set_texture(load(global_configs.LEARN_TITLE_YELLOW))
			set_theme(load(global_configs.THEME_YELLOW))
			get_node("ColorRect/OptionButton/Separator").color = Color(global_configs.COLOR_BLACK)
		"blue":
			colorRect.color = Color(global_configs.COLOR_BLUE)
			titleTexture.set_texture(load(global_configs.LEARN_TITLE_BLUE))
			set_theme(load(global_configs.THEME_BLUE))
		"purple":
			colorRect.color = Color(global_configs.COLOR_PURPLE)
			titleTexture.set_texture(load(global_configs.LEARN_TITLE_PURPLE))
			set_theme(load(global_configs.THEME_PURPLE))
		"black":
			colorRect.color = Color(global_configs.COLOR_BLACK)
			titleTexture.set_texture(load(global_configs.LEARN_TITLE_BLACK))
			set_theme(load(global_configs.THEME_BLACK))
		"red":
			colorRect.color = Color(global_configs.COLOR_RED)
			titleTexture.set_texture(load(global_configs.LEARN_TITLE_RED))
			set_theme(load(global_configs.THEME_RED))


func _on_OptionButton_item_selected(id):
	match id:
		6:
			_updateView()
		0:
			_updateView('Asia')
		1:
			_updateView('Europe')
		2:
			_updateView('North America')
		3:
			_updateView('South America')
		4:
			_updateView('Africa')
		5:
			_updateView('Oceania')
		
