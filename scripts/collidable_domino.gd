class_name DominoCollidable
extends Collidable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass

func get_collidable_parent_node() -> Node3D:
	print("Getting Parent")
	print(get_parent().get_parent().get_parent().name)
	return get_parent().get_parent().get_parent()

func get_collidable_type() -> CollidableType:
	return CollidableType.DOMINO
