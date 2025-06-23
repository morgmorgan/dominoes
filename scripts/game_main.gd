extends Node

@onready var main_menu : mainMenu = $mainMenu
@onready var levels_menu : levelsMenu = $levelsMenu
@onready var instruction_menu : instructionMenu = $instructionMenu
@onready var options_menu : optionsMenu = $optionsMenu

func _ready():
	main_menu.levelsButton_pressed.connect(show_levels_menu)
	main_menu.optionsButton_pressed.connect(show_options_menu)
	main_menu.instructionButton_pressed.connect(show_instruction_menu)
	
	levels_menu.menuButton_pressed.connect(show_main_menu)
	levels_menu.level_requested.connect(load_level)
	
	options_menu.menuButton_pressed.connect(show_main_menu)
	
	instruction_menu.menuButton_pressed.connect(show_main_menu)
	
func load_level(level_index : int):
	if level_index == 0:
		show_main_menu()
	else:
		hide_all_menus()
	
	$AnimationPlayer.play("load_fade_out")
	$levelLoader.load_level(level_index)
	$AnimationPlayer.play("load_fade_in")
	
func hide_all_menus():
	main_menu.visible = false
	levels_menu.visible = false
	instruction_menu.visible = false
	options_menu.visible = false
	
func show_main_menu():
	main_menu.visible = true
	levels_menu.visible = false
	instruction_menu.visible = false
	options_menu.visible = false
	
func show_levels_menu():
	main_menu.visible = false
	levels_menu.visible = true
	instruction_menu.visible = false
	options_menu.visible = false
	
func show_instruction_menu():
	main_menu.visible = false
	levels_menu.visible = false
	instruction_menu.visible = true
	options_menu.visible = false
	
func show_options_menu():
	main_menu.visible = false
	levels_menu.visible = false
	instruction_menu.visible = false
	options_menu.visible = true
