extends Control
class_name FlagSelector

signal selected

@onready var indicator_1p: TextureRect = %Indicator1P
@onready var indicator_2p: TextureRect = %Indicator2P
@onready var animation_player: AnimationPlayer = %AnimationPlayer

var control_sceme := Player.ControlScheme.P1
var is_selected := false

func _ready() -> void:
	indicator_1p.visible = control_sceme == Player.ControlScheme.P1
	indicator_2p.visible = control_sceme == Player.ControlScheme.P2
	
func _process(_delta: float) -> void:
	if not is_selected and KeyUtils.is_action_just_pressed(control_sceme, KeyUtils.Action.SHOOT):
		is_selected = true
		animation_player.play("selected")
		SoundPlayer.play(SoundPlayer.Sound.UI_SELECT)
		selected.emit()
	elif is_selected and KeyUtils.is_action_just_pressed(control_sceme, KeyUtils.Action.PASS):
		is_selected = false
		animation_player.play("selecting")
		
