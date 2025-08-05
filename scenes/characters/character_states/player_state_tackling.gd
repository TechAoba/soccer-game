extends PlayerState
class_name PlayerStateTackling

const DURATION_PRIOR_RECOVERY := 200
const GROUND_FRICTION := 250.0

var is_tackle_complete := false
var time_finish_tackle := Time.get_ticks_msec()

func _enter_tree() -> void:
	animation_player.play("tackle")
	tackle_damage_emiiter_area.monitoring = true

func _process(delta: float) -> void:
	# 铲球速度平缓下降
	if not is_tackle_complete:
		player.velocity = player.velocity.move_toward(Vector2.ZERO, delta * GROUND_FRICTION)
		if player.velocity == Vector2.ZERO:
			is_tackle_complete = true
			time_finish_tackle = Time.get_ticks_msec()
	# 铲球动作结束后进入recovery状态
	elif Time.get_ticks_msec() - time_finish_tackle > DURATION_PRIOR_RECOVERY:
		state_transition_requested.emit(Player.State.RECOVERING)

func _exit_tree() -> void:
	tackle_damage_emiiter_area.monitoring = false
