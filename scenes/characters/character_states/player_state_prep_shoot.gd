extends PlayerState
class_name PlayerStatePrepShoot

const DURATION_MAX_BONUS := 1000.0
const EASE_REWARD_FACTOR := 2.0

var shot_direction: Vector2
var time_start_shot := Time.get_ticks_msec()

func _enter_tree() -> void:
	animation_player.play("prep_shoot")
	player.velocity = Vector2.ZERO
	shot_direction = player.heading

func _process(delta: float) -> void:
	shot_direction += KeyUtils.get_input_vector(player.control_scheme) * delta
	if KeyUtils.is_action_just_released(player.control_scheme, KeyUtils.Action.SHOOT):
		var duration_press := clampf(Time.get_ticks_msec() - time_start_shot, 0.0, DURATION_MAX_BONUS)
		var ease_time := duration_press / DURATION_MAX_BONUS
		var bonus := ease(ease_time, EASE_REWARD_FACTOR)
		var shoot_power := player.power * (1 + bonus)
		shot_direction = shot_direction.normalized()
		# 切换到shoot状态时，传递射门的角度和力度
		var state_data = PlayerStateData.build().set_shoot_direction(shot_direction).set_shoot_power(shoot_power)
		transition_state(Player.State.SHOOTING, state_data)

func can_pass() -> bool:
	return true
