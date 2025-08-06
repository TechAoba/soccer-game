extends PlayerState
class_name PlayerStateChestControl

const DURATION_CONTROL := 500
var enter_time_tick: int

func _enter_tree() -> void:
	animation_player.play("chest_control")
	player.velocity = Vector2.ZERO
	enter_time_tick = Time.get_ticks_msec()

func _process(_delta: float) -> void:
	if Time.get_ticks_msec() - enter_time_tick >= DURATION_CONTROL:
		transition_state(Player.State.MOVING)

func can_pass() -> bool:
	return true
