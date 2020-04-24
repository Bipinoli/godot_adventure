extends Node


const SAVE_FILE_NAME = "user://gameState.save"


func _setup():
	var game_state = load_game()
	if game_state == null:
		game_state = {
			'casual_high_score_right': 0,
			'casual_high_score_wrong': 0,
			'timed_high_score_right': 0,
			'timed_high_score_wrong': 0,
			'survival_high_score': 0,
			'theme': 'green'
		}
		save_game(game_state)
	

func saveCasualHighScore(right, wrong):
	var game_state = load_game()
	game_state['casual_high_score_right'] = right
	game_state['casual_high_score_wrong'] = wrong
	save_game(game_state)
	
func saveTimedHighScore(right, wrong):
	var game_state = load_game()
	game_state['timed_high_score_right'] = right
	game_state['timed_high_score_wrong'] = wrong
	save_game(game_state)
	
func saveSurvivalHighScore(correct):
	var game_state = load_game()
	game_state['survival_high_score'] = correct
	save_game(game_state)
	
func saveTheme(theme):
	var game_state = load_game()
	game_state['theme'] = theme
	save_game(game_state)


func getCasualHighScore():
	var game_state = load_game()
	return [game_state['casual_high_score_right'], game_state['casual_high_score_wrong']]
	
func getTimedHighScore():
	var game_state = load_game()
	return [game_state['timed_high_score_right'], game_state['timed_high_score_wrong']]
	
func getSurvivalHighScore():
	var game_state = load_game()
	return game_state["survival_high_score"]

func getTheme():
	var game_state = load_game()
	return game_state['theme']



func save_game(game_state={}):
	var save_game = File.new()
	save_game.open(SAVE_FILE_NAME, File.WRITE)
	save_game.store_line(to_json(game_state))
	save_game.close()
	
	
func load_game():
	var save_game = File.new()
	if not save_game.file_exists(SAVE_FILE_NAME):
		return null
	save_game.open(SAVE_FILE_NAME, File.READ)
	return parse_json(save_game.get_line())

