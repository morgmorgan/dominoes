extends Node

const ANGLE_INCREMENT = 15

signal spawn_angle_changed
signal tile_active(tile_node_name : String)

var spawn_angle : int = 0

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
			
# Yes I know this is the mouse wheel tracker singleton I just didn't
# think it was worth writing an entirely new singleton for one function
# and signal
#
# If I wasn't too lazy to change every reference to mousewheeltracker I would
# just rename this singleton to "EventManager" or something
func new_active_tile(tile_node_name : String):
	tile_active.emit(tile_node_name)
