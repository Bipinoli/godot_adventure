extends Node



var data = null
var countries = []
var question = {}


func _init():
	var file = File.new()
	file.open("res://data/countries.json", file.READ)
	var json = file.get_as_text()
	file.close()
	data = JSON.parse(json).get_result()
	print(data["Afghanistan"])
	for d in data:
		countries.push_back(d)


	
func _getRandomInteger(lo, hi, exceptions):
	while true:
		var retval = randi()%hi + lo
		var invalid = false
		for num in exceptions:
			if retval == num:
				invalid = true
				break 
		if not invalid:
			return retval
			

func _selectProperOption(lo, hi, exceptions):
	while true:
		var retval = _getRandomInteger(lo, hi, exceptions)
		if 'city' in data[countries[retval]] and data[countries[retval]]['city'] != null:
			return retval
	
	
func _prepareQuestion():
	randomize()
	var num1 = _getRandomInteger(0, len(countries), [])
	while not 'flag' in data[countries[num1]]:
		num1 = _getRandomInteger(0, len(countries), [])
	var num2 = _selectProperOption(0, len(countries), [num1])
	var num3 = _selectProperOption(0, len(countries), [num1, num2])
	var num4 = _selectProperOption(0, len(countries), [num1, num2, num3])
	question['country'] = countries[num1]
	question['answer'] = data[countries[num1]]['city']
	question['flag'] = data[countries[num1]]['flag']
	var options = []
	options.push_back(_getRandomInteger(0, 4, options))
	options.push_back(_getRandomInteger(0, 4, options))
	options.push_back(_getRandomInteger(0, 4, options))
	options.push_back(_getRandomInteger(0, 4, options))
	var nums = [num1, num2, num3, num4]
	question['option1'] = data[countries[nums[options[0]]]]['city']
	question['option2'] = data[countries[nums[options[1]]]]['city']
	question['option3'] = data[countries[nums[options[2]]]]['city']
	question['option4'] = data[countries[nums[options[3]]]]['city']
	return question

