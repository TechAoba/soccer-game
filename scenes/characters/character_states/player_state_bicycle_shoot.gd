extends PlayerState
class_name PlayerStateBicycleShoot

const BALL_HEIGHT_MIN := 5.0
const BALL_HEIGHT_MAX := 25.0
const BONUS_POWER := 2.0

func _enter_tree() -> void:
	animation_player.play("bicycle_shoot")
	ball_detection_area.body_entered.connect(on_body_entered.bind())


func on_body_entered(contact_ball: Ball) -> void:
	if contact_ball.can_air_connect(BALL_HEIGHT_MIN, BALL_HEIGHT_MAX):
		var destination := target_goal.get_random_target_position()
		var direction := ball.position.direction_to(destination)
		ball.shoot(direction * player.power * BONUS_POWER)


func on_animation_complete() -> void:
	transition_state(Player.State.RECOVERING)
