class_name levelInterface extends CanvasLayer

func _ready():
	$helpContainer.visible = false
	%helpButton.toggled.connect(toggle_help_panel)

func toggle_help_panel(toggled_on : bool):
	$helpContainer.visible = toggled_on
