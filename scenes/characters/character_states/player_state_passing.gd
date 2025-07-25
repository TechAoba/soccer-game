extends PlayerState
class_name PlayerStatePassing

func _enter_tree() -> void:
	animation_player.play("shooting")
	player.velocity = Vector2.ZERO
	
func on_animation_complete() -> void:
	var pass_target := find_teammate_in_view()
	# 玩家传球时前方没有人，则像玩家朝向传球一定距离
	if pass_target == null:
		ball.pass_to(ball.position + player.heading * player.speed)
	else:
		ball.pass_to(pass_target.position + pass_target.velocity)
	transition_state(Player.State.MOVING)
	
	
func find_teammate_in_view() -> Player:
	var players_in_view := teammate_detection_area.get_overlapping_bodies()
	var teammates_in_view := players_in_view.filter(
		func(p: Player): return p != player
	)
	var target_player: Player = null
	# 选择可视范围中最近的玩家
	for person in teammates_in_view:
		if target_player == null:
			target_player = person
		elif person.position.distance_squared_to(player.position) < target_player.position.distance_squared_to(player.position):
			target_player = person
	return target_player
