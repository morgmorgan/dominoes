extends Node3D

signal button_changed(pressed: bool)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _button_state_passthrough(pressed: bool) -> void:
	button_changed.emit(pressed)
	pass # Replace with function body.
