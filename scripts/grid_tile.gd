class_name gridTile extends Node3D

const GRIDTILE_SCENE : PackedScene = preload("res://scenes/grid_tile.tscn")
const GHOST_DOMINO_SCENE : PackedScene = preload("res://scenes/ghost_domino_basic.tscn")
const DOMINO_SCENE : PackedScene = preload("res://scenes/domino.tscn")
const HIGHLIGHT_MATERIAL : StandardMaterial3D = preload("res://resources/gridtile_hilight.tres")
const NORMAL_MATERIAL : StandardMaterial3D = preload("res://resources/gridtile_normal.tres")

#@export var tile_id : String = "tile0"
@export var current_domino : Domino = null

@export var start_domino:bool = false
@export var locked_domino = false
@export var spawn_angle = 0

#TODO: DOMINO TYPE SHOULD BE SET FROM UI
@export var type: Domino.DominoType = Domino.DominoType.GENERIC

var spawn_point: Vector3 = $".".position
var ghost : Node3D = null
var mouse_active = false

# Static Constructor for spawning via code
#static func new_gridTile(tile_id : String, current)-> gridTile:
#	var new_tile : gridTile = GRIDTILE_SCENE.instantiate()
#	new_tile.tile_id = tile_id
#	return new_tile

func _ready():
	if start_domino or locked_domino:
		spawn_domino(start_domino)
	else:
		#%mouseArea.mouse_entered.connect(on_mouseover)
		%mouseArea.mouse_exited.connect(on_mouse_off)
		%mouseArea.input_event.connect(on_tile_input)
		MouseWheelTracker.spawn_angle_changed.connect(show_ghost)
		MouseWheelTracker.tile_active.connect(check_active_tile)

func check_active_tile(tile_node_name : String):
	print(tile_node_name)
	if name != tile_node_name:
		mouse_active = false
		remove_ghost()
	else:
		mouse_active = true	
		show_ghost()
		
	
#func on_mouseover():
	#MouseWheelTracker.new_active_tile(name)
	#mouse_active = true
	#show_ghost()
	#
func on_mouse_off():
	remove_ghost()
	
func on_tile_input(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int):
	check_active_tile(MouseWheelTracker.spawn_input_handler(camera, event, event_position, normal, shape_idx))
	
	if not mouse_active:
		return
	
	if Input.is_action_just_pressed("LeftMouseClick"):
		$AnimationPlayer.play("clicked")
		spawn_domino(false)
	if Input.is_action_just_pressed("RightMouseClick"):
		$AnimationPlayer.play("rightClicked")
		remove_domino()
		
func spawn_domino(start_domino: bool):#, spawn_angle: float):
	if current_domino != null:
		return
	var new_domino : Domino = DOMINO_SCENE.instantiate()
	new_domino.type = type
	new_domino.start_domino = start_domino
	new_domino.rotation_degrees = Vector3(0, MouseWheelTracker.spawn_angle, 0)
	new_domino.position = spawn_point
	current_domino = new_domino
	add_child(current_domino, true)
	%dominoPlaceSFX.play()
	
func remove_domino():
	if current_domino == null:
		return
	remove_child(current_domino)
	current_domino = null
	
func remove_ghost():
	if ghost != null:
		remove_child(ghost)
		ghost = null

func show_ghost():
	if (current_domino != null) or not mouse_active:
		return
	
	remove_ghost()
	
	var new_ghost : Node3D = GHOST_DOMINO_SCENE.instantiate()
	new_ghost.rotation_degrees = Vector3(0, MouseWheelTracker.spawn_angle, 0)
	new_ghost.position = spawn_point
	ghost = new_ghost
	add_child(new_ghost, true)
