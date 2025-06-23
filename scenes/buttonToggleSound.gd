extends AudioStreamPlayer

func _ready():
	if get_parent() is TextureButton:
		get_parent().pressed.connect(play)
