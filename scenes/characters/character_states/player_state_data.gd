class_name PlayerStateData

var shoot_direction : Vector2
var shoot_power : float

static func build() -> PlayerStateData:
	return PlayerStateData.new()
	
func set_shoot_direction(direction: Vector2) -> PlayerStateData:
	shoot_direction = direction
	return self
	

func set_shoot_power(power: float) -> PlayerStateData:
	shoot_power = power
	return self
	
