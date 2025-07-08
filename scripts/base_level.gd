class_name baseLevel extends Node

@export var interface : levelInterface
@export var level_body : PackedScene

@export_category("Dominoes")
@export var normal_dominoes : int = 0
@export var heavy_dominoes : int = 0
@export var jumping_dominoes : int = 0

var nd_max
var hd_max
var jd_max

var active_level : Node3D

signal menuButton_pressed

func _ready():
	if (interface == null) or (level_body == null):
		return
	
	interface.menuButton_pressed.connect(emit_menuButton)
	interface.refreshButton_pressed.connect(refresh_level)
	interface.playButton_pressed.connect(play_level)
	
	interface.update_normal_count(normal_dominoes)
	interface.update_heavy_count(heavy_dominoes)
	interface.update_jumping_count(jumping_dominoes)
	
	nd_max = normal_dominoes
	hd_max = heavy_dominoes
	jd_max = jumping_dominoes
	
	var new_level = level_body.instantiate()
	active_level = new_level
	add_child(active_level)
	
func emit_menuButton():
	menuButton_pressed.emit()

func refresh_level():
	remove_child(active_level)
	active_level.queue_free()
	
	var new_level = level_body.instantiate()
	active_level = new_level
	
	normal_dominoes = nd_max
	heavy_dominoes = hd_max
	jumping_dominoes = jd_max
	
	interface.update_normal_count(normal_dominoes)
	interface.update_heavy_count(heavy_dominoes)
	interface.update_jumping_count(jumping_dominoes)
	
	add_child(active_level)
	
func play_level():
	active_level.play_level()

func check_normal() -> bool:
	if normal_dominoes > 0:
		normal_dominoes -= 1
		interface.update_normal_count(normal_dominoes)
		return true
	else:
		return false
		
func check_heavy() -> bool:
	if heavy_dominoes > 0:
		heavy_dominoes -= 1
		interface.update_heavy_count(heavy_dominoes)
		return true
	else:
		return false
		
func check_jumping() -> bool:
	if jumping_dominoes > 0:
		jumping_dominoes -= 1
		interface.update_jumping_count(jumping_dominoes)		
		return true
	else:
		return false
		
func restore_domino(type: Domino.DominoType):
	match type:
		Domino.DominoType.GENERIC:
			normal_dominoes += 1
			interface.update_normal_count(normal_dominoes)
		Domino.DominoType.HEAVY:
			heavy_dominoes += 1
			interface.update_heavy_count(heavy_dominoes)
		Domino.DominoType.JUMPING:
			jumping_dominoes += 1
			interface.update_jumping_count(jumping_dominoes)
