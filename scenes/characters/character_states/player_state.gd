extends Node
class_name PlayerState

signal state_transition_requested(new_state: Player.State, state_data: PlayerStateData)

var ai_behavior : AIBehavior = null
var animation_player: AnimationPlayer = null
var ball: Ball = null
var ball_detection_area = null
var own_goal: Goal = null
var player: Player = null
var state_data: PlayerStateData = PlayerStateData.new()
var target_goal: Goal = null
var tackle_damage_emiiter_area: Area2D = null
var teammate_detection_area: Area2D = null


func setup(context_player: Player, context_state_data: PlayerStateData,
		context_animation_player: AnimationPlayer, context_ball: Ball, 
		context_teammate_detection_area: Area2D,
		context_ball_detection_area: Area2D,
		context_own_goal: Goal, context_target_goal: Goal,
		context_tackle_damage_emiiter_area: Area2D,
		context_ai_behavior: AIBehavior) -> void:
	animation_player = context_animation_player
	ball = context_ball
	ball_detection_area = context_ball_detection_area
	own_goal = context_own_goal
	player = context_player
	state_data = context_state_data
	teammate_detection_area = context_teammate_detection_area
	target_goal = context_target_goal
	tackle_damage_emiiter_area = context_tackle_damage_emiiter_area
	ai_behavior = context_ai_behavior


func transition_state(new_state: Player.State, state_data: PlayerStateData = PlayerStateData.new()) -> void:
	state_transition_requested.emit(new_state, state_data)
	

func on_animation_complete() -> void:
	pass 

func can_carry_body() -> bool:
	return false

func can_pass() -> bool:
	return false

func is_ready_for_kickoff() -> bool:
	return false
