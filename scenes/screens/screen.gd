extends Node
class_name Screen

signal screen_transition_requested(new_screen: SoccerGame.ScreenType, data: ScreenData)

var game : SoccerGame = null
var screen_data : ScreenData = null

func set_up(context_game: SoccerGame, context_screen_data: ScreenData) -> void:
	game = context_game
	screen_data = context_screen_data


func transition_screen(new_screen: SoccerGame.ScreenType, data: ScreenData = ScreenData.new()) -> void:
	screen_transition_requested.emit(new_screen, data)
