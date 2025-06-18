extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_domino()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

func how_many_dominoes() -> int:
	var dominoes = $".".find_children("domino*", "", true, false)	
	return dominoes.size()

func add_domino() -> void:
	var dom = preload("res://scenes/domino.tscn")
	var x = dom.instantiate()
	x.owner  = $"."
	print(how_many_dominoes())
	add_child(x, true)
	print(how_many_dominoes())


func _process(delta: float) -> void:
	
	pass
