extends Node

const ANGLE_INCREMENT = 15

signal spawn_angle_changed

var spawn_angle : int = 0

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("MouseWheelUp"):
		spawn_angle += ANGLE_INCREMENT
		spawn_angle_changed.emit()
		print_debug(spawn_angle)
	if Input.is_action_just_pressed("MouseWheelDown"):
		spawn_angle -= ANGLE_INCREMENT
		spawn_angle_changed.emit()
		print_debug(spawn_angle)
