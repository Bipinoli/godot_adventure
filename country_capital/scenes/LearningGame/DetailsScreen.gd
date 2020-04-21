extends Control


export var test_country_name = "United Arab Emirates the great nation in the galaxy known to all mankind through out the ages"


onready var flag = get_node("ColorRect/FlagArea/Flag")
onready var country = get_node("ColorRect/DetailsArea/Country")
onready var detailsContainer = get_node("ColorRect/DetailsArea/ScrollContainer/VBoxContainer")

var gameManager = load("res://scenes/LearningGame/LearningGameManager.gd").new()


func _ready():
	gameManager._init()
	_setup("China")


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
			listItem.rect_min_size.y = 60
			detailsContainer.call_deferred("add_child", listItem)
			listItem.call_deferred("_setup", title, description)
