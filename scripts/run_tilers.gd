@tool
extends EditorScript
		
func _run() -> void:
	for tiled:Tiler in get_scene().find_children("*", "Tiler", true, true):
		tiled.create_nodes()
		
