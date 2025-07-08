extends GridMap

const GHOST_DOMINO_SCENE : PackedScene = preload("res://scenes/ghost_domino_basic.tscn")
const DOMINO_SCENE : PackedScene = preload("res://scenes/domino.tscn")

#TODO: DOMINO TYPE SHOULD BE SET FROM UI
@export var type: Domino.DominoType = Domino.DominoType.GENERIC

var dominos = {}
var ghost

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MouseWheelTracker.spawn_angle_changed.connect(show_ghost)
	MouseWheelTracker.spawn_domino.connect(spawn_domino)
	MouseWheelTracker.spawn_changed.connect(show_ghost)
	MouseWheelTracker.remove_domino.connect(remove_domino)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var camera = get_viewport().get_camera_3d()
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_length = 100;
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * ray_length
	var space = get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.create(from, to)
	ray_query.collide_with_areas = true
	
	var raycast_result = space.intersect_ray(ray_query)
	if raycast_result.has("position") and not (raycast_result["collider"] is Collidable and (raycast_result["collider"] as Collidable).get_collidable_type() == Collidable.CollidableType.DOMINO):
		if get_cell_item($".".map_to_local(raycast_result["position"])) == 0:
			MouseWheelTracker.update_spawn($".".map_to_local(raycast_result["position"]))
			return 
			
	MouseWheelTracker.clear_spawn()
	
	if raycast_result.has("position") and (raycast_result["collider"] is Collidable and (raycast_result["collider"] as Collidable).get_collidable_type() == Collidable.CollidableType.DOMINO):
		var domino = (raycast_result["collider"] as Collidable).get_collidable_parent_node()
		MouseWheelTracker.update_domino(domino)
	else:
		MouseWheelTracker.clear_domino()	
	
		
func spawn_domino():#, spawn_angle: float):
	if not MouseWheelTracker.active:
		return
	
	if dominos.has(MouseWheelTracker.currrent_spawn):
		return
		
	var new_domino : Domino = DOMINO_SCENE.instantiate()
	new_domino.type = type
	new_domino.rotation_degrees = Vector3(0, MouseWheelTracker.spawn_angle, 0)
	new_domino.position = MouseWheelTracker.currrent_spawn
	dominos[MouseWheelTracker.currrent_spawn] = new_domino
	add_sibling(new_domino, true)
	%dominoPlaceSFX.position = MouseWheelTracker.currrent_spawn
	%dominoPlaceSFX.play()

func remove_domino():
	if MouseWheelTracker.current_domino == null:
		return
	
	var pos = dominos.find_key(MouseWheelTracker.current_domino)
	if pos != null:
		get_parent().remove_child(MouseWheelTracker.current_domino)
		dominos.erase(pos)
	else:
		print("tried removing a domino that wasnt placed")
	
func remove_ghost():
	if ghost != null:
		get_parent().remove_child(ghost)
		ghost = null

func show_ghost():
	remove_ghost()
	
	if dominos.has(MouseWheelTracker.currrent_spawn) or not MouseWheelTracker.active:
		return

	var new_ghost : Node3D = GHOST_DOMINO_SCENE.instantiate()
	new_ghost.rotation_degrees = Vector3(0, MouseWheelTracker.spawn_angle, 0)
	new_ghost.position = MouseWheelTracker.currrent_spawn
	ghost = new_ghost
	add_sibling(new_ghost, true)
