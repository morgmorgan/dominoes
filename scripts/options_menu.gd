class_name optionsMenu extends CanvasLayer

signal menuButton_pressed

func _ready():
	%menuButton.pressed.connect(emit_menuButton)
	
func emit_menuButton():
	menuButton_pressed.emit()
