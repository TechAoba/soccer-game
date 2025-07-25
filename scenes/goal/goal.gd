extends Node2D
class_name Goal

@onready var back_net_area := %BackNetArea

func _ready() -> void:
	back_net_area.body_entered.connect(on_ball_enter_back_net.bind())
	
func on_ball_enter_back_net(ball: Ball) -> void:
	ball.stop()
