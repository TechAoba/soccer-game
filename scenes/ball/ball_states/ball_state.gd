extends Node
class_name BallState

signal state_transition_requested(new_state: Ball.State)

const GRAVITY := 10.0

var ball: Ball = null
var carrier: Player = null
var animation_player: AnimationPlayer = null
var player_detection_area: Area2D = null
var sprite: Sprite2D = null

func set_up(context_ball: Ball, context_player_detection_area: Area2D
	, context_carrier: Player, context_animation_player: AnimationPlayer
	, context_sprite: Sprite2D) -> void:
		
	ball = context_ball
	player_detection_area = context_player_detection_area
	carrier = context_carrier
	animation_player = context_animation_player
	sprite = context_sprite


func set_ball_animation_from_velocity():
	if ball.velocity == Vector2.ZERO:
		animation_player.play("idle")
	elif ball.velocity.x >= 0:
		animation_player.play("roll")
		animation_player.advance(0)
	else:
		animation_player.play_backwards("roll")
		animation_player.advance(0)

func process_gravity(delta: float, bounciness: float = 0.0) -> void:
	if ball.height > 0 or ball.height_velocity > 0:
		ball.height_velocity -= GRAVITY * delta
		ball.height = ball.height + ball.height_velocity
		# 确保球不会向下穿透地面
		if ball.height < 0:
			ball.height = 0
			if bounciness > 0 and ball.height_velocity < 0:
				ball.height_velocity = -ball.height_velocity * bounciness
				ball.velocity *= bounciness


func move_and_bounce(delta: float) -> void:
	var collision := ball.move_and_collide(ball.velocity * delta)
	if collision != null:
		ball.velocity = ball.velocity.bounce(collision.get_normal()) * ball.BOUNCINESS
		ball.switch_state(Ball.State.FREEFORM)
