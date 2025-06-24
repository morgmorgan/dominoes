extends Node3D

func _ready():
	$buttonTile.button_changed.connect(on_win_tile_button_changed)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("levelStart"):
		play_level()

func on_win_tile_button_changed(pressed: bool) -> void:
	if pressed:
		$AudioStreamPlayer.play(0.3)
		
func play_level():
	for domino: Domino in get_tree().get_nodes_in_group("dominoes"):
		if domino.start_domino:
			domino.tip_domino()
