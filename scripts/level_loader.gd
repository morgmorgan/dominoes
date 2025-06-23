class_name levelLoader extends Node

@export var levels : Array[PackedScene]

var active_level : Node

func _ready():
	active_level = get_child(0)
	
func load_level(level_index : int):
	if active_level != null:
		active_level.queue_free()
		active_level = null
		
	var new_level = levels[level_index].instantiate()
	active_level = new_level
	add_child(active_level)
