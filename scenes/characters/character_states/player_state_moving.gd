extends PlayerState
class_name PlayerStateMoving

func _process(_delta: float) -> void:
	if player.control_scheme == Player.ControlScheme.CPU:
		pass # process AI control
	else:
		hanle_human_movement()
	
	# 根据人物速度，调用不同的动画
	player.set_movement_animation()
	# 根据人物x轴速度，改变人物的朝向
	player.set_heading()
	

func hanle_human_movement():
	# 归一化向量
	var direction := KeyUtils.get_input_vector(player.control_scheme)
	player.velocity = direction * player.speed
	
	if player.has_ball() and KeyUtils.is_action_just_pressed(player.control_scheme, KeyUtils.Action.SHOOT):
		transition_state(Player.State.PREP_SHOOT)
	
	#if player.velocity != Vector2.ZERO and KeyUtils.is_action_just_pressed(player.control_scheme, KeyUtils.Action.SHOOT):
		#state_transition_requested.emit(Player.State.TACKLING)
