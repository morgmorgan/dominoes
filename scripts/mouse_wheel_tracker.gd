extends Node

const ANGLE_INCREMENT = 15

signal spawn_angle_changed
signal tile_active(tile_node_name : String)

var current_tile: String
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
func spawn_input_handler(camera: Camera3D, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int):
	var spawn_pts = get_tree().get_nodes_in_group("spawn_points")
	var norms = spawn_pts.map(func(x: Node3D): return camera.unproject_position(x.global_position)).map(func(y: Vector2): return (event.position - y).length())
	
	var d = {}
	
	for i in range(spawn_pts.size()):
		d.get_or_add(spawn_pts[i], norms[i])
	
	var sorted = d.values()
	sorted.sort()
	
	var closest = d.find_key(sorted[0])
	if closest.name != current_tile:
		current_tile = closest.name
		tile_active.emit(closest.name)
