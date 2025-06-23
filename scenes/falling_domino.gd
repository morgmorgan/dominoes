extends RigidBody3D

func _ready():
	$Timer.timeout.connect(queue_free)
