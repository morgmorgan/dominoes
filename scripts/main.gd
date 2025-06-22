extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#add_domino()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("MouseWheelClick"):
		for domino: Domino in get_tree().get_nodes_in_group("dominoes"):
			if domino.start_domino:
				domino.tip_domino()
	pass
	
func how_many_dominoes() -> int:
	var dominoes = $".".find_children("domino*", "", true, false)	
	return dominoes.size()


func _on_win_tile_button_changed(pressed: bool) -> void:
	if pressed:
		print("You Won! Get back to work now.")
		$AudioStreamPlayer.play(0.3)
	pass # Replace with function body.
