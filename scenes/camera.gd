extends Camera2D
class_name Camera

const DISTANCE_TARGET := 100.0
const SMOOTHING_BALL_CARRIED := 2
const SMOOTHING_BALL_DEFAULT := 8

@export var ball : Ball

func _process(_delta: float) -> void:
	if ball.carrier != null:
		position = ball.position + ball.carrier.heading * DISTANCE_TARGET
		position_smoothing_speed = SMOOTHING_BALL_CARRIED
	else:
		position = ball.position
		position_smoothing_speed = SMOOTHING_BALL_DEFAULT
