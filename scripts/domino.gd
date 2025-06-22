class_name Domino
extends Node3D

@export var start_domino:bool = false
@export var type: DominoType = DominoType.GENERIC

enum DominoType {GENERIC, HEAVY}

var already_tipped = false
var how_many_collided_with_me = 0

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

func _check_generic(area: Area3D) -> bool:
	return type == DominoType.GENERIC and area is Collidable and (area as Collidable).get_collidable_type() == Collidable.CollidableType.DOMINO

func _check_heavy(area: Area3D) -> bool:
	if type != DominoType.HEAVY:
		return false
	if area is Collidable and (area as Collidable).get_collidable_type() == Collidable.CollidableType.DOMINO:
		var collidable = area as DominoCollidable
		var other_domino = collidable.get_collidable_parent_node()		
		var other_player: AnimationPlayer = other_domino.find_child("AnimationPlayer")
		
		if other_domino.type == DominoType.HEAVY:
			how_many_collided_with_me += 2
		else:
			how_many_collided_with_me += 1
		
		other_player.pause()

	return how_many_collided_with_me >= 2
	
	pass

func _on_domino_area_entered(area_rid: RID, area: Area3D, area_shape_index: int, local_shape_index: int) -> void:
	if not already_tipped:
		if _check_generic(area) or _check_heavy(area):
			var collidable = area as DominoCollidable
			var other_domino = collidable.get_collidable_parent_node()
			var other_rigid: RigidBody3D = other_domino.find_child("RigidBody3D", true)
			var other_player: AnimationPlayer = other_domino.find_child("AnimationPlayer")
			print(name, " tipped over by ", other_domino.name)
			tip_domino()
			other_player.pause()
			#other_rigid.gravity_scale = 1
			
