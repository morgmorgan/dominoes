class_name optionsMenu extends CanvasLayer

const VOLUME_MAX = 0


signal menuButton_pressed

func _ready():
	%menuButton.pressed.connect(emit_menuButton)
	%sfxSlider.value_changed.connect(update_sfx_level)
	%musicSlider.value_changed.connect(update_bgm_level)
	
	%musicToggleButton.toggled.connect(toggle_music)
	%sfxToggleButton.toggled.connect(toggle_sfx)
	
func emit_menuButton():
	menuButton_pressed.emit()
	
func update_sfx_level(value : float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(value))
	
func update_bgm_level(value : float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("BGM"), linear_to_db(value))
	
func toggle_music(toggled_on : bool):
	AudioServer.set_bus_mute(AudioServer.get_bus_index("BGM"), toggled_on)
	
func toggle_sfx(toggled_on : bool):
	AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), toggled_on)
	
