extends Node
class_name AIBehavior

const DURATION_AI_TICK_FREQUENCY := 200

var ball : Ball = null
var opponent_detection_area: Area2D = null
var player : Player = null
var time_since_last_ai_tick := Time.get_ticks_msec()

func _ready() -> void:
	time_since_last_ai_tick = Time.get_ticks_msec() + randi_range(0, DURATION_AI_TICK_FREQUENCY)

func setup(context_ball: Ball, context_player: Player, context_opponent_detection_area: Area2D) -> void:
	ball = context_ball
	player = context_player
	opponent_detection_area = context_opponent_detection_area

func process_ai() -> void:
	if Time.get_ticks_msec() - time_since_last_ai_tick > DURATION_AI_TICK_FREQUENCY:
		time_since_last_ai_tick = Time.get_ticks_msec()
		perform_ai_movement()
		perform_ai_decision()

func perform_ai_movement() -> void:
	pass

func perform_ai_decision() -> void:
	pass
	
func get_bicircular_weight(position: Vector2, center_target: Vector2
		, inner_circular_radius: float, inner_circular_weight
		, outer_circular_radius: float, outer_circular_weight) -> float:
	var distance_to_center := position.distance_to(center_target)
	if distance_to_center > outer_circular_radius:
		return outer_circular_weight
	if distance_to_center < inner_circular_radius:
		return inner_circular_weight
	var distance_to_inner_radius := distance_to_center - inner_circular_radius
	var close_range_distance := outer_circular_radius - inner_circular_radius
	# 插值
	return lerpf(inner_circular_weight, outer_circular_weight, distance_to_inner_radius / close_range_distance)

func face_towards_target_goal() -> void:
	if not player.is_facing_target_goal():
		player.heading = player.heading * -1

func is_ball_possessed_by_opponent() -> bool:
	return ball.carrier != null and ball.carrier.country != player.country

func is_ball_carried_by_teammate() -> bool:
	return ball.carrier != null and ball.carrier != player and ball.carrier.country == player.country

func has_opponents_nearby() -> bool:
	var players := opponent_detection_area.get_overlapping_bodies()
	return players.find_custom(func(p: Player): return p.country != player.country) > -1
