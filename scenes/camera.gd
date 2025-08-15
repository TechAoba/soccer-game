extends Camera2D
class_name Camera

const DISTANCE_TARGET := 100.0
const DURATION_SHARK := 120.0
const SHARK_INTENSITY := 5
const SMOOTHING_BALL_CARRIED := 2
const SMOOTHING_BALL_DEFAULT := 8

var is_sharking := false
var time_start_shark := Time.get_ticks_msec()

@export var ball : Ball

func _init() -> void:
	GameEvents.impact_received.connect(on_impact_received.bind())

func _process(_delta: float) -> void:
	if ball.carrier != null:
		position = ball.position + ball.carrier.heading * DISTANCE_TARGET
		position_smoothing_speed = SMOOTHING_BALL_CARRIED
	else:
		position = ball.position
		position_smoothing_speed = SMOOTHING_BALL_DEFAULT
	
	if is_sharking and Time.get_ticks_msec() - time_start_shark < DURATION_SHARK:
		offset = Vector2(randf_range(-SHARK_INTENSITY, SHARK_INTENSITY), randf_range(-SHARK_INTENSITY, SHARK_INTENSITY))
	else:
		is_sharking = false
		offset = Vector2.ZERO
		

func on_impact_received(_impact_position: Vector2, is_high_received: bool) -> void:
	if is_high_received:
		is_sharking = true
		time_start_shark = Time.get_ticks_msec()
