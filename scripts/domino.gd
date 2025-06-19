class_name Domino
extends Node3D

@export var start_domino:bool = false
var already_tipped = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#if start_domino:
		#tip_domino()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass

func _on_anim_end(anim_name: StringName) -> void:
	pass
	#if anim_name == "tip_over":
		#print("tip over ended for ", name)
		#$physisc/RigidBody3D.gravity_scale = 1

func tip_domino() -> void:
	if not already_tipped:
		$AnimationPlayer.play("tip_over")
		already_tipped = true

func _on_domino_area_entered(area_rid: RID, area: Area3D, area_shape_index: int, local_shape_index: int) -> void:
	if not already_tipped:
		if area is Collidable and (area as Collidable).collidableType == Collidable.CollidableType.DOMINO:
			var other_domino = area.get_parent().get_parent().get_parent()
			var other_rigid: RigidBody3D = area.get_parent()
			var other_player: AnimationPlayer = other_domino.find_child("AnimationPlayer")
			print(name, "tipped over by ", other_domino.name)
			tip_domino()
			other_player.pause()
			#other_rigid.gravity_scale = 1
			
