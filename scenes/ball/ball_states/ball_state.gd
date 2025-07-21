extends Node
class_name BallState

signal state_transition_requested(new_state: Ball.State)

var ball: Ball = null
var carrier: Player = null
var animation_player: AnimationPlayer = null
var player_detection_area: Area2D = null

func set_up(context_ball: Ball, context_player_detection_area: Area2D
	, context_carrier: Player, context_animation_player: AnimationPlayer) -> void:
	ball = context_ball
	player_detection_area = context_player_detection_area
	carrier = context_carrier
	animation_player = context_animation_player
