class_name levelLoader extends Node

signal parent_load_level(level_id : int)

@export var levels : Array[PackedScene]

var active_level : baseLevel

func _ready():
	active_level = get_child(0)
	
func load_level(level_index : int):
	if active_level != null:
		active_level.queue_free()
		active_level = null
		
	var new_level = levels[level_index].instantiate()
	active_level = new_level
	active_level.menuButton_pressed.connect(request_level.bind(0))
	add_child(active_level)

func request_level(level_id : int):
	parent_load_level.emit(level_id)
