extends Control

@onready var pause_menu = $Panel2
var paused = false

func _on_resume_pressed() -> void:
	GUIBuss.pause_menu_resume_button_pressed.emit()

func _on_options_pressed() -> void:
	GUIBuss.pause_menu_options_button_pressed.emit()

func _on_home_pressed() -> void:
	GUIBuss.pause_menu_home_button_pressed.emit()
