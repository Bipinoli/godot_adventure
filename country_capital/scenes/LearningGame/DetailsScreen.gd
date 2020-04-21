extends Control


export var test_country_name = "United Arab Emirates the great nation in the galaxy known to all mankind through out the ages"


onready var flag = get_node("ColorRect/FlagArea/Flag")
onready var country = get_node("ColorRect/DetailsArea/Country")
onready var detailsContainer = get_node("ColorRect/DetailsArea/ScrollContainer/VBoxContainer")
onready var global_configs = get_node("/root/GlobalConfigurations")
onready var scene_changer = get_node("/root/SceneChanger")

var gameManager = load("res://scenes/LearningGame/LearningGameManager.gd").new()


func _ready():
	gameManager._init()
	_setup(global_configs.detail_selected_country)
	_applyTheme(global_configs.theme)


func _notification(what):
	match what:
		MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
			print("go back from details screen --------------------------------------------")
			scene_changer.changeScene("res://scenes/LearningGame/LearningGame.tscn")


func _setup(country_name):
	var details = gameManager._retrieveCountryDetails(country_name)
	_updateView(details)
	
func _updateView(details):
	for d in detailsContainer.get_children():
		detailsContainer.call_deferred("remove_child", d)
		d.queue_free()
	country.set_text(details['country'])
	flag._set_flag(flag._get_flag_texture(details['details']['flag']))
	if 'currency_name' in details['details']:
		if 'currency_code' in details['details']:
			details['details']['currency_name'] += " (" + details['details']['currency_code'] + ")"
	if 'landlocked' in details['details']:
		details['details']['landlocked'] = 'yes' if details['details']['landlocked'] == '1' else 'no'
	if 'area' in details['details']:
		details['details']['area'] = str(details['details']['area']) + " sq. km"
	if 'expectancy' in details['details']:
		details['details']['expectancy'] += " yrs"
	
	var detailPriority = ['city', 'continent', 'location', 'landlocked', 'dish', 'government', 'expectancy', 'language', 'currency_name', 'area', 'elevation', 'temperature', 'calling_code', 'tld']
	var detailName = ['Capital city', 'Continent', 'Location', 'Landlocked', 'Cuisine', 'Government', 'Life Expectency', 'Language', 'Currency', 'Surface Area', 'Elevation', 'Avg. Annual Temperature', 'Calling code', 'Internet Domain']

	for i in range(len(detailPriority)):
		if detailPriority[i] in details['details']:
			var title = detailName[i]
			var description = details['details'][detailPriority[i]]
			if typeof(description) == typeof([]):
				var text = ""
				for i in range(len(description)):
					if i > 0:
						text += ", "
					text += description[i]
				description = text
			var listItem = load("res://scenes/LearningGame/DetailInfo.tscn").instance()
			listItem.rect_min_size.y = 40
			detailsContainer.call_deferred("add_child", listItem)
			listItem.call_deferred("_setup", title, description)



func _applyTheme(color):
	var colorRect = get_node("ColorRect")
	var titleTexture = get_node("ColorRect/TitleTexture")
	match color:
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
