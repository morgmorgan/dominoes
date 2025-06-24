class_name baseLevel extends Node

@export var interface : levelInterface
@export var level_body : PackedScene

@export_category("Dominoes")
@export var normal_dominoes : int = 1
@export var heavy_dominoes : int = 0
@export var jumping_dominoes : int = 0

var active_level : Node3D

signal menuButton_pressed

func _ready():
	if (interface == null) or (level_body == null):
		return
	
	interface.menuButton_pressed.connect(emit_menuButton)
	interface.refreshButton_pressed.connect(refresh_level)
	interface.playButton_pressed.connect(play_level)
	
	interface.update_normal_count(normal_dominoes)
	interface.update_heavy_count(heavy_dominoes)
	interface.update_jumping_count(jumping_dominoes)
	
	var new_level = level_body.instantiate()
	active_level = new_level
	add_child(active_level)
	
func emit_menuButton():
	menuButton_pressed.emit()

func refresh_level():
	remove_child(active_level)
	var new_level = level_body.instantiate()
	active_level = new_level
	add_child(active_level)
	
func play_level():
	Input.action_press("levelStart")
