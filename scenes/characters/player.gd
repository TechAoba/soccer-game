extends CharacterBody2D
class_name Player

enum ControlScheme { CPU, P1, P2 }
enum State { MOVING, TACKLING, RECOVERING, PREP_SHOOT, SHOOTING, PASSING }

const CONTROL_SCHEME_MAP : Dictionary = {
	ControlScheme.CPU : preload("res://assets/art/props/cpu.png"),
	ControlScheme.P1 : preload("res://assets/art/props/1p.png"),
	ControlScheme.P2 : preload("res://assets/art/props/2p.png"),
}

@export var ball: Ball
@export var control_scheme: ControlScheme
@export var speed: float = 80.0
@export var power: float = 70.0

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var control_sprite: Sprite2D = %ControlSprite
@onready var player_sprite: Sprite2D = %PlayerSprite
@onready var teammate_detection_area: Area2D = %TeammateDetectionArea

var current_state: PlayerState = null
var heading := Vector2.RIGHT
var state_factory := PlayerStateFactory.new()

func _ready() -> void:
	set_control_texture()
	switch_state(State.MOVING)
	

func _process(_delta: float) -> void:
	flip_sprite()
	set_sprite_visibility()
	# 让玩家移动起来，直接使用move_and_slide()即可
	move_and_slide()


func switch_state(state: State, state_data: PlayerStateData = PlayerStateData.new()) -> void:
	if current_state != null:
		current_state.queue_free()
	current_state = state_factory.get_fresh_state(state)
	current_state.setup(self, state_data, animation_player, ball, teammate_detection_area)
	# 将切换状态信号绑定该函数，每次切换状态都将销毁旧状态，创立新状态
	current_state.state_transition_requested.connect(switch_state.bind())
	current_state.name = "PlayerStateMachine: " + str(state)
	call_deferred("add_child", current_state)
	

func set_movement_animation():
	if velocity.length() > 0:
		animation_player.play("run")
	else:
		animation_player.play("idle")


func set_heading():
	if velocity.x > 0:
		heading = Vector2.RIGHT
	elif velocity.x < 0:
		heading = Vector2.LEFT
	

func flip_sprite() -> void:
	if heading == Vector2.RIGHT:
		player_sprite.flip_h = false
	elif heading == Vector2.LEFT:
		player_sprite.flip_h = true


func set_sprite_visibility() -> void:
	# 持球的CPU或者真人玩家会显示control标志
	control_sprite.visible = has_ball() or not control_scheme == ControlScheme.CPU


func has_ball() -> bool:
	return ball.carrier == self


func set_control_texture() -> void:
	control_sprite.texture = CONTROL_SCHEME_MAP[control_scheme]


func on_animation_complete() -> void:
	if current_state != null:
		current_state.on_animation_complete()
