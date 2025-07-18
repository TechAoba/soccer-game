extends CharacterBody2D
class_name Player

enum ControlScheme { CPU, P1, P2 }
enum State { MOVING, TACKLING, RECOVERING }

@export var control_scheme: ControlScheme
@export var speed: float = 80.0

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var player_sprite: Sprite2D = %PlayerSprite

var current_state: PlayerState = null
var heading := Vector2.RIGHT
var state_factory := PlayerStateFactory.new()

func _ready() -> void:
	switch_state(State.MOVING)
	

func _process(_delta: float) -> void:
	flip_sprite()
	# 让玩家移动起来，直接使用move_and_slide()即可
	move_and_slide()


func switch_state(state: State) -> void:
	if current_state != null:
		current_state.queue_free()
	current_state = state_factory.get_fresh_state(state)
	current_state.setup(self, animation_player)
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
