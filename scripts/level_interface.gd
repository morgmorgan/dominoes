class_name levelInterface extends CanvasLayer

signal menuButton_pressed
signal refreshButton_pressed
signal playButton_pressed

func emit_menuButton():
	menuButton_pressed.emit()
	
func emit_playButton():
	playButton_pressed.emit()
	%playButton.release_focus()
	
func emit_resetButton():
	refreshButton_pressed.emit()
	%resetButton.release_focus()

func _ready():
	$helpContainer.visible = false
	%helpButton.toggled.connect(toggle_help_panel)
	%menuButton.pressed.connect(emit_menuButton)
	%resetButton.pressed.connect(emit_resetButton)
	%playButton.pressed.connect(emit_playButton)

func toggle_help_panel(toggled_on : bool):
	$helpContainer.visible = toggled_on

func update_normal_count(count : int):
	%normalDominoCountLabel.text = str(count)
	
func update_heavy_count(count : int):
	%heavyDominoCountLabel.text = str(count)
	
func update_jumping_count(count : int):
	%jumpingDominoCountLabel.text = str(count)
