extends Node3D

signal button_changed(pressed: bool)

const GREEN_MATERIAL : StandardMaterial3D = preload("res://resources/gridtile_clicked.tres")
const RED_MATERIAL : StandardMaterial3D = preload("res://resources/gridtile_rightClicked.tres")

var button_pressed = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func hold_button_down() -> void:
	$AnimationPlayer.play("button_pressed")
	$Cylinder_001.set_surface_override_material(0, GREEN_MATERIAL)
	button_pressed = true
	button_changed.emit(button_pressed)
	
func unpress_button() -> void:
	$AnimationPlayer.play("button_pressed", -1, -1.0, true)
	$Cylinder_001.set_surface_override_material(0, RED_MATERIAL)
	button_pressed = false
	button_changed.emit(button_pressed)

func _on_area_3d_area_shape_entered(area_rid: RID, area: Area3D, area_shape_index: int, local_shape_index: int) -> void:
	hold_button_down()
	pass # Replace with function body.

func _on_area_3d_area_shape_exited(area_rid: RID, area: Area3D, area_shape_index: int, local_shape_index: int) -> void:
	unpress_button()
	pass # Replace with function body.
