extends BallState
class_name BallStateFreeform

func _enter_tree() -> void:
	player_detection_area.body_entered.connect(on_player_enter.bind())
	
	
func on_player_enter(body: Player):
	ball.carrier = body
	state_transition_requested.emit(Ball.State.CARRIED)
