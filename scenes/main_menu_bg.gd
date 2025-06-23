extends Node3D

@export var falling_domino_scene : PackedScene
@export var domino_spawn_point : Node3D

func _ready():
	$spawnTimer.timeout.connect(spawn_domino)
	
func spawn_domino():
	var new_domino : RigidBody3D = falling_domino_scene.instantiate()
	new_domino.position = domino_spawn_point.position
	new_domino.position.x += randf_range(-25,15)
	new_domino.position.y += randf_range(-5,5)
	
	new_domino.angular_velocity.x += randf_range(-2,2)
	new_domino.angular_velocity.y += randf_range(-2,2)
	new_domino.angular_velocity.z+= randf_range(-2,2)
	
	new_domino.rotation.x += randf_range(-45,45)
	new_domino.rotation.y += randf_range(-45,45)
	new_domino.rotation.z += randf_range(-45,45)
	
	add_child(new_domino)
