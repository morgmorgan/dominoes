class_name Collidable
extends Area3D

enum CollidableType {GENERIC, DOMINO}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_collidable_parent_node():
	print("Getting Parent, Badly")
	pass
	
func get_collidable_type() -> CollidableType:
	return CollidableType.GENERIC
