extends Node

const ANGLE_INCREMENT = 15

signal spawn_angle_changed
signal spawn_changed(tile_node_name : String)
signal spawn_domino
signal remove_domino

var spawn_angle : int = 0
var currrent_spawn: Vector3
var active = false

var current_domino: Domino

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("MouseWheelUp"):
		if spawn_angle < 180:
			spawn_angle += ANGLE_INCREMENT
			spawn_angle_changed.emit()
			#print_debug(spawn_angle)
	if Input.is_action_just_pressed("MouseWheelDown"):
		if spawn_angle > -180:
			spawn_angle -= ANGLE_INCREMENT
			spawn_angle_changed.emit()
			#print_debug(spawn_angle)
	if Input.is_action_just_pressed("LeftMouseClick"):
		spawn_domino.emit()
	if Input.is_action_just_pressed("RightMouseClick"):
		remove_domino.emit()
			
# Yes I know this is the mouse wheel tracker singleton I just didn't
# think it was worth writing an entirely new singleton for one function
# and signal
#
# If I wasn't too lazy to change every reference to mousewheeltracker I would
# just rename this singleton to "EventManager" or something
func update_spawn(position: Vector3):
	if position != currrent_spawn or not active:
		currrent_spawn = position
		active = true
		spawn_changed.emit()
		
		
func update_domino(domino: Domino):
	current_domino = domino
func clear_domino():
	current_domino = null
		
func clear_spawn():
	if active: 
		active = false
		spawn_changed.emit()
