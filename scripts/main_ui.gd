class_name mainMenu extends CanvasLayer

signal levelsButton_pressed
signal instructionButton_pressed
signal optionsButton_pressed

func _ready():
	%levelsButton.pressed.connect(emit_levelButton)
	%instructionButton.pressed.connect(emit_instructionButton)
	%optionsButton.pressed.connect(emit_optionsButton)
	%quitButton.pressed.connect(get_tree().quit)
	
func emit_levelButton():
	levelsButton_pressed.emit()
	
func emit_optionsButton():
	optionsButton_pressed.emit()
	
func emit_instructionButton():
	instructionButton_pressed.emit()
