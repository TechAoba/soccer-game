extends PlayerState
class_name PlayerStateMoving

func _process(_delta: float) -> void:
	if player.control_scheme == Player.ControlScheme.CPU:
		ai_behavior.process_ai()
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
	
	if player.velocity != Vector2.ZERO:
		teammate_detection_area.rotation = player.velocity.angle()
		
	if KeyUtils.is_action_just_pressed(player.control_scheme, KeyUtils.Action.PASS):
		if player.has_ball():
			transition_state(Player.State.PASSING)
		elif can_teammate_pass_ball():
			ball.carrier.get_pass_request(player)
		else:
			player.swap_requested.emit(player)
	elif KeyUtils.is_action_just_pressed(player.control_scheme, KeyUtils.Action.SHOOT):
		if player.has_ball():
			transition_state(Player.State.PREP_SHOOT)
		elif ball.can_air_interact():
			if player.velocity == Vector2.ZERO:
				# 如果玩家面向目标球门 凌空抽射
				if player.is_facing_target_goal():
					transition_state(Player.State.VOLLEY_SHOOT)
				# 背对目标球门 倒挂金钩
				else:
					transition_state(Player.State.BICYCLE_SHOOT)
			else:
				transition_state(Player.State.HEADER)
		elif player.velocity != Vector2.ZERO:
			transition_state(Player.State.TACKLING)

func can_carry_body() -> bool:
	return player.role != Player.Role.GOALIE

func can_teammate_pass_ball() -> bool:
	return ball.carrier != null and ball.carrier.country == player.country and ball.carrier.control_scheme == Player.ControlScheme.CPU

func can_pass() -> bool:
	return true
