extends PlayerState
class_name PlayerStateShooting


func _enter_tree() -> void:
	animation_player.play("shooting")


func on_animation_complete() -> void:
	if player.control_scheme == Player.ControlScheme.CPU:
		transition_state(Player.State.RECOVERING)
	else:
		transition_state(Player.State.MOVING)
	shoot_ball()


func shoot_ball() -> void:
	ball.shoot(state_data.shoot_direction * state_data.shoot_power)
