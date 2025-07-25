class_name PlayerStateFactory

var states: Dictionary

func _init() -> void:
	states = {
		Player.State.MOVING: PlayerStateMoving,
		Player.State.PREP_SHOOT: PlayerStatePrepShoot,
		Player.State.RECOVERING: PlayerStateRecovering,
		Player.State.SHOOTING: PlayerStateShooting,
		Player.State.PASSING: PlayerStatePassing,
		Player.State.TACKLING: PlayerStateTackling
	}

func get_fresh_state(state: Player.State) -> PlayerState:
	assert(states.has(state), "state does not exist!")
	return states.get(state).new()
