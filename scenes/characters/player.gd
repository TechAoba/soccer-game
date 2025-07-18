extends CharacterBody2D
class_name Player

enum ControlScheme { CPU, P1, P2 }

@export var control_scheme: ControlScheme
@export var speed: float = 80.0

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var player_sprite: Sprite2D = %PlayerSprite

var heading := Vector2.RIGHT


func _process(_delta: float) -> void:
	if control_scheme == ControlScheme.CPU:
		pass # process AI control
	else:
		hanle_human_movement()
	
	# 根据人物x轴速度，改变人物的朝向
	set_heading()
	flip_sprite()
	# 根据人物速度，调用不同的动画
	set_movement_animation()
	# 让玩家移动起来，直接使用move_and_slide()即可
	move_and_slide()


func hanle_human_movement():
	# 归一化向量
	var direction := KeyUtils.get_input_vector(control_scheme)
	velocity = direction * speed


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
