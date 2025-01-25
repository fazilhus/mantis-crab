class_name HUD
extends CanvasLayer

@onready var menu : Control = %Menu
@onready var options : Control = %Options
@onready var pause : Control = %Pause

enum OptionsMenuPrevious {MAIN, PAUSE}
var options_previous : OptionsMenuPrevious

func _ready() -> void:
	GUIBuss.game_started.connect(_on_game_started)
	GUIBuss.menu_options_button_pressed.connect(_on_menu_options_button_pressed)
	GUIBuss.option_menu_back_button_pressed.connect(_on_option_menu_back_button_pressed)



func _on_game_started() -> void:
	_show_main_menu()

func _on_menu_options_button_pressed() -> void:
	options_previous = OptionsMenuPrevious.MAIN
	_show_options_menu()

func _on_option_menu_back_button_pressed() -> void:
	match options_previous:
		OptionsMenuPrevious.MAIN:
			_show_main_menu()
		OptionsMenuPrevious.PAUSE:
			_show_pause_menu()

func _on_pause_menu_resume_button_pressed() -> void:
	_hide_pause_menu()

func _on_pause_menu_options_button_pressed() -> void:
	options_previous = OptionsMenuPrevious.PAUSE
	_show_options_menu()

func _on_pause_menu_home_button_pressed() -> void:
	_show_main_menu()

func _show_main_menu() -> void:
	menu.show()
	options.hide()
	pause.hide()

func _show_options_menu() -> void:
	menu.show()
	options.show()
	pause.hide()

func _show_pause_menu() -> void:
	menu.show()
	options.hide()
	pause.show()

func _hide_pause_menu() -> void:
	menu.show()
	options.hide()
	pause.hide()