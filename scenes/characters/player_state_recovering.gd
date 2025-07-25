extends PlayerState
class_name PlayerStateRecovering

const DURATION_RECOVERING := 500

var time_start_recovery := Time.get_ticks_msec()

func _enter_tree() -> void:
	player.velocity = Vector2.ZERO
	animation_player.play("recover")


func _process(_delta: float) -> void:
	if Time.get_ticks_msec() - time_start_recovery > DURATION_RECOVERING:
		transition_state(Player.State.MOVING)
