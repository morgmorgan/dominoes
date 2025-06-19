extends Node3D

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
	
func unpress_button() -> void:
	$AnimationPlayer.play("button_pressed", -1, -1.0, true)
	$Cylinder_001.set_surface_override_material(0, RED_MATERIAL)
	button_pressed = true
