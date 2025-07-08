class_name levelsMenu extends CanvasLayer

signal menuButton_pressed
signal level_requested(level_number : int)

func _ready():
	%menuButton.pressed.connect(emit_menuButton)
	%level1Button.pressed.connect(request_level.bind(1))
	%level2Button.pressed.connect(request_level.bind(2))
	
func emit_menuButton():
	menuButton_pressed.emit()
	
func request_level(level_number):
	level_requested.emit(level_number)
