class_name gridTile extends Node3D

const GRIDTILE_SCENE : PackedScene = preload("res://scenes/grid_tile.tscn")
const DOMINO_SCENE : PackedScene = preload("res://scenes/domino.tscn")
const HIGHLIGHT_MATERIAL : StandardMaterial3D = preload("res://resources/gridtile_hilight.tres")
const NORMAL_MATERIAL : StandardMaterial3D = preload("res://resources/gridtile_normal.tres")
const ANGLE_INCREMENT = 15

@export var tile_id : String = "tile0"
@export var current_domino : Domino = null

@onready var spawn_point : Vector3 = $dominoSpawnPoint.position
@onready var tile_gfx : MeshInstance3D = $tileModel/MeshInstance3D
@export var start_domino:bool = false

var spawn_angle = 0
var mouse_active = false

# Static Constructor for spawning via code
static func new_gridTile(tile_id : String, current)-> gridTile:
	var new_tile : gridTile = GRIDTILE_SCENE.instantiate()
	new_tile.tile_id = tile_id
	return new_tile

func _ready():
	if start_domino:
		spawn_domino(true)
	else:
		%mouseArea.mouse_entered.connect(on_mouseover)
		%mouseArea.mouse_exited.connect(on_mouse_off)
		%mouseArea.input_event.connect(on_tile_input)
	
func on_mouseover():
	tile_gfx.set_surface_override_material(0, HIGHLIGHT_MATERIAL)
	mouse_active = true
	
func on_mouse_off():
	tile_gfx.set_surface_override_material(0, NORMAL_MATERIAL)
	mouse_active = false
	
func _process(delta: float) -> void:
	if mouse_active:
		if Input.is_action_just_pressed("MouseWheelUp"):
			spawn_angle += ANGLE_INCREMENT
			print(spawn_angle)
		if Input.is_action_just_pressed("MouseWheelDown"):
			spawn_angle -= ANGLE_INCREMENT
			print(spawn_angle)
	
func on_tile_input(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int):
	if Input.is_action_just_pressed("LeftMouseClick"):
		$AnimationPlayer.play("clicked")
		spawn_domino(false)
	if Input.is_action_just_pressed("RightMouseClick"):
		$AnimationPlayer.play("rightClicked")
		remove_domino()
		
func spawn_domino(start_domino: bool):
	if current_domino != null:
		return
	var new_domino : Domino = DOMINO_SCENE.instantiate()
	new_domino.start_domino = start_domino
	new_domino.rotation_degrees = Vector3(0, spawn_angle, 0)
	new_domino.position = spawn_point
	current_domino = new_domino
	add_child(current_domino, true)
	
func remove_domino():
	if current_domino == null:
		return
	remove_child(current_domino)
	current_domino = null
