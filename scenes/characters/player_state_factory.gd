class_name PlayerStateFactory

var states: Dictionary

func _init() -> void:
	states = {
		Player.State.BICYCLE_SHOOT: PlayerStateBicycleShoot, 
		Player.State.CHEST_CONTROL: PlayerStateChestContorl,
		Player.State.DIVING: PlayerStateDiving,
		Player.State.HEADER: PlayerStateHeader,
		Player.State.HURT: PlayerStateHurt,
		Player.State.MOVING: PlayerStateMoving,
		Player.State.PREP_SHOOT: PlayerStatePrepShoot,
		Player.State.RECOVERING: PlayerStateRecovering,
		Player.State.SHOOTING: PlayerStateShooting,
		Player.State.PASSING: PlayerStatePassing,
		Player.State.TACKLING: PlayerStateTackling,
		Player.State.VELLY_SHOOT: PlayerStateVellyShoot, 
	}

func get_fresh_state(state: Player.State) -> PlayerState:
	assert(states.has(state), "state does not exist!")
	return states.get(state).new()
