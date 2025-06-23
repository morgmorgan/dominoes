@tool
class_name Tiler
extends Node

@export var SceneResource : PackedScene
@export var origin: Node3D
@export var end: Node3D
@export var width: int = 1
@export var length: int = 1

func create_nodes() -> void:
	print(width, " ", length, " ", origin.position, " ", end.position)
	
	for child in $".".get_children():
		remove_child(child)
	
	var way2 = Vector3(origin.position.x, 0.0, end.position.z)
	var way1 = Vector3(end.position.x, 0.0, origin.position.z)
	
	for i in range(width):
		for j in range(length):
			print(i, ", ", j)
			
			var x_com = origin.position.lerp(way1, 1.0/(width - 1) * i)
			var z_com = origin.position.lerp(way2, 1.0/(length - 1) * j)
			
			var scene : Node3D = SceneResource.instantiate()
			scene.position = Vector3(x_com.x, 0, z_com.z)
			add_child(scene, true)
			print("current owner: ", scene.owner)
			scene.set_owner(get_tree().edited_scene_root)
			print("current owner: ", scene.owner)
			print("added ", scene.name)
