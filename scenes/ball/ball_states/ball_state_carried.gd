extends BallState
class_name BallStateCarried

const OFFSET_FROM_PLAYER := Vector2(10.0, 4.0)
const DRIBBLE_FREQUENCY := 10.0
const DRIBBLE_INTENSITY_LOW := 3.0
const DRIBBLE_INTENSITY_HIGH := 6.0

var dribble_time: float = 0.0
var rng := RandomNumberGenerator.new()
var kick_period: float
var dribble_intensity: float = DRIBBLE_INTENSITY_LOW
# 带球时球的摆动值
var vx := 0.0


func _enter_tree() -> void:
	assert(carrier != null, "carrier can not be null!")
	kick_period = TAU / DRIBBLE_FREQUENCY

func _process(delta: float) -> void:
	if carrier.velocity != Vector2.ZERO:
		# 时间相关变量，控制球的摆动频率
		dribble_time += delta
		if dribble_time >= kick_period:
			dribble_time -= kick_period
			dribble_intensity = rng.randf_range(DRIBBLE_INTENSITY_LOW, DRIBBLE_INTENSITY_HIGH)
		if carrier.velocity.x != 0:
			vx = cos(dribble_time * DRIBBLE_FREQUENCY) * dribble_intensity
		# 面朝左需要反向播放球滚动动画
		if carrier.heading.x >= 0:
			animation_player.play("roll")
			animation_player.advance(0)
		else:
			animation_player.play_backwards("roll")
			# 同时使用正反向播放会让godot感到困惑，使用advance(0)强制进入下一帧
			animation_player.advance(0)
	else:
		animation_player.play("idle")
	process_gravity(delta)

	ball.position = carrier.position + Vector2(vx + carrier.heading.x * OFFSET_FROM_PLAYER.x, OFFSET_FROM_PLAYER.y)
	
