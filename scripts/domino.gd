extends Node3D

@export var start_domino:bool = false
var already_tipped = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if start_domino:
		$AnimationPlayer.play("tip_over")
		already_tipped = true
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass

func _on_anim_end(anim_name: StringName) -> void:
	pass
	#if anim_name == "tip_over":
		#print("tip over ended for ", name)
		#$physisc/RigidBody3D.gravity_scale = 1
	
func _on_area_3d_area_shape_entered(area_rid: RID, area: Area3D, area_shape_index: int, local_shape_index: int) -> void:
	if not already_tipped:
		var other_domino = area.get_parent().get_parent().get_parent()
		var other_rigid: RigidBody3D = area.get_parent()
		var other_player: AnimationPlayer = other_domino.find_child("AnimationPlayer")
		print(name, "tipped over by ", other_domino.name)
		$AnimationPlayer.play("tip_over")
		other_player.pause()
		#other_rigid.gravity_scale = 1
		
		
		
		already_tipped = true
