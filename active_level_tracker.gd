extends Node

signal level_changed

var current_level: Node
var current_index: int = 0 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func update_level(level_index: int, new_level):
	if current_index != level_index:
		level_changed.emit()
		current_index = level_index
		current_level = new_level
	pass
