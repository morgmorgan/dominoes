class_name gridTile extends Node3D

const GRIDTILE_SCENE : PackedScene = preload("res://scenes/grid_tile.tscn")
const DOMINO_SCENE : PackedScene = preload("res://scenes/domino.tscn")
const HIGHLIGHT_MATERIAL : StandardMaterial3D = preload("res://resources/gridtile_hilight.tres")
const NORMAL_MATERIAL : StandardMaterial3D = preload("res://resources/gridtile_normal.tres")

@export var tile_id : String = "tile0"

@onready var domino_spawn_point : Vector3 = $dominoSpawnPoint.position
@onready var tile_gfx : MeshInstance3D = $tileModel/MeshInstance3D

static func new_gridTile(tile_id : String)-> gridTile:
	var new_tile : gridTile = GRIDTILE_SCENE.instantiate()
	new_tile.tile_id = tile_id
	return new_tile

func _ready():
	%mouseArea.mouse_entered.connect(on_mouseover)
	%mouseArea.mouse_exited.connect(on_mouse_off)
	%mouseArea.input_event.connect(on_tile_input)
	
func on_mouseover():
	tile_gfx.set_surface_override_material(0, HIGHLIGHT_MATERIAL)
	
func on_mouse_off():
	tile_gfx.set_surface_override_material(0, NORMAL_MATERIAL)
	
func on_tile_input(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int):
	if Input.is_action_just_pressed("LeftMouseClick"):
		$AnimationPlayer.play("clicked")
	if Input.is_action_just_pressed("RightMouseClick"):
		$AnimationPlayer.play("rightClicked")
