class_name AIBehaviorFactory

var roles : Dictionary

func _init() -> void:
	roles = {
		Player.Role.GOALIE: AIBehaviorGoalie,
		Player.Role.MIDFIELD: AIBehaviorField,
		Player.Role.DEFENSE: AIBehaviorField,
		Player.Role.OFFENSE: AIBehaviorField,
	}

func get_ai_hehavior(role: Player.Role) -> AIBehavior:
	assert(roles.has(role), "role doesn't esist!")
	return roles.get(role).new()
