class_name HUD
extends CanvasLayer

@onready var menu : MainMenu = %Menu
@onready var options : OptionsMenu = %Options
@onready var pause : PauseMenu = %Pause

enum OptionsPrevious {MAIN, PAUSE}
var options_previous : OptionsPrevious

func _ready() -> void:
	GUIBuss.game_started.connect(_on_game_started)
	GUIBuss.level_started.connect(_on_level_started)
	GUIBuss.menu_options_button_pressed.connect(_on_menu_options_button_pressed)
	GUIBuss.option_menu_back_button_pressed.connect(_on_option_menu_back_button_pressed)
	GUIBuss.pause_game.connect(_on_pause_game)

	GUIBuss.pause_menu_resume_button_pressed.connect(_on_pause_menu_resume_button_pressed)
	GUIBuss.pause_menu_options_button_pressed.connect(_on_pause_menu_options_button_pressed)
	GUIBuss.pause_menu_home_button_pressed.connect(_on_pause_menu_home_button_pressed)

func _on_game_started() -> void:
	_show_main_menu()

func _on_level_started() -> void:
	_hide_main_menu()

func _on_pause_game() -> void:
	_show_pause_menu()

func _on_menu_options_button_pressed() -> void:
	options_previous = OptionsPrevious.MAIN
	_show_options_menu()

func _on_option_menu_back_button_pressed() -> void:
	match options_previous:
		OptionsPrevious.MAIN:
			_show_main_menu()
		OptionsPrevious.PAUSE:
			_show_pause_menu()

func _on_pause_menu_resume_button_pressed() -> void:
	_hide_pause_menu()

func _on_pause_menu_options_button_pressed() -> void:
	options_previous = OptionsPrevious.PAUSE
	_show_options_menu()

func _on_pause_menu_home_button_pressed() -> void:
	_show_main_menu()

func _show_main_menu() -> void:
	menu.show()
	menu.default_focus.grab_focus()
	options.hide()
	pause.hide()
	_capture_mouse(false)

func _hide_main_menu() -> void:
	menu.hide()
	options.hide()
	pause.hide()
	_capture_mouse(true)

func _show_options_menu() -> void:
	menu.hide()
	options.show()
	options.default_focus.grab_focus()
	pause.hide()
	_capture_mouse(false)

func _show_pause_menu() -> void:
	menu.hide()
	options.hide()
	pause.show()
	pause.default_focus.grab_focus()
	_capture_mouse(false)

func _hide_pause_menu() -> void:
	menu.hide()
	options.hide()
	pause.hide()
	_capture_mouse(true)

func _capture_mouse(val: bool) -> void:
	if val:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
