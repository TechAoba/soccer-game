extends BallState
class_name BallStateCarried

func _enter_tree() -> void:
	assert(carrier != null, "carrier can not be null!")

func _process(_delta: float) -> void:
	ball.position = carrier.position
