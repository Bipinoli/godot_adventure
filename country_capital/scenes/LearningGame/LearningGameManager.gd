extends Node


var data = null
var countries = []

func _init():
	var file = File.new()
	file.open("res://data/countries.json", file.READ)
	var json = file.get_as_text()
	file.close()
	data = JSON.parse(json).get_result()
	print(data["Afghanistan"])
	for d in data:
		countries.push_back(d)

func _retrieveCountries(continent=null):
	var retval = []
	for country in countries:
		if 'city' in data[country] and data[country]['city'] != null:
			if 'flag' in data[country] and data[country]['flag'] != null:
				if (continent and data[country]['continent'] == continent) or (not continent):
					retval.push_back({'country': country, 'capital': data[country]['city'], 'flag': data[country]['flag']})
	return retval
	
	
func _retrieveCountryDetails(country):
	var retval = {'country': country, 'details': {} }
	for key in data[country].keys():
		if data[country][key] != null:
			retval['details'][key] = data[country][key]
	return retval

