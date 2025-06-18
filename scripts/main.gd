extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#add_domino()
	pass # Replace with function body.

func how_many_dominoes() -> int:
	var dominoes = $".".find_children("domino*", "", true, false)	
	return dominoes.size()

func add_domino(pos: Vector3) -> void:
	var dom = preload("res://scenes/domino.tscn")
	var x = dom.instantiate()
	x.owner  = $"."
	print(how_many_dominoes())
	add_child(x, true)
	x.position = pos
	print(how_many_dominoes())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass

func _on_floor_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		var mouse_action : InputEventMouseButton = event
		if mouse_action.button_index == 1 and mouse_action.pressed == true:
			add_domino(event_position)
		print(event, event_position)
