class_name gridTile extends Node3D

const GRIDTILE_SCENE : PackedScene = preload("res://scenes/grid_tile.tscn")
const GHOST_DOMINO_SCENE : PackedScene = preload("res://scenes/ghost_domino_basic.tscn")
const DOMINO_SCENE : PackedScene = preload("res://scenes/domino.tscn")
const HIGHLIGHT_MATERIAL : StandardMaterial3D = preload("res://resources/gridtile_hilight.tres")
const NORMAL_MATERIAL : StandardMaterial3D = preload("res://resources/gridtile_normal.tres")

@export var tile_id : String = "tile0"
@export var current_domino : Domino = null

@onready var spawn_point : Vector3 = $dominoSpawnPoint.position
@onready var tile_gfx : MeshInstance3D = $tileModel/MeshInstance3D
@export var start_domino:bool = false
@export var locked_domino = false
@export var spawn_angle = 0

var ghost : Node3D = null
var mouse_active = false

# Static Constructor for spawning via code
static func new_gridTile(tile_id : String, current)-> gridTile:
	var new_tile : gridTile = GRIDTILE_SCENE.instantiate()
	new_tile.tile_id = tile_id
	return new_tile

func _ready():
	if start_domino or locked_domino:
		spawn_domino(start_domino)
	else:
		%mouseArea.mouse_entered.connect(on_mouseover)
		%mouseArea.mouse_exited.connect(on_mouse_off)
		%mouseArea.input_event.connect(on_tile_input)
		MouseWheelTracker.spawn_angle_changed.connect(show_ghost)
	
func on_mouseover():
	tile_gfx.set_surface_override_material(0, HIGHLIGHT_MATERIAL)
	mouse_active = true
	show_ghost()
	
func on_mouse_off():
	tile_gfx.set_surface_override_material(0, NORMAL_MATERIAL)
	mouse_active = false
	remove_ghost()
	
func on_tile_input(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int):
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
	if (current_domino != null) or !mouse_active:
		return
	
	remove_ghost()
	
	var new_ghost : Node3D = GHOST_DOMINO_SCENE.instantiate()
	new_ghost.rotation_degrees = Vector3(0, MouseWheelTracker.spawn_angle, 0)
	new_ghost.position = spawn_point
	ghost = new_ghost
	add_child(new_ghost, true)
