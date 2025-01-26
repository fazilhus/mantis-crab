class_name MainMenu
extends Control

@onready var default_focus : Control = %PlayButton

func _on_play_button_pressed() -> void:
	GUIBuss.play_button_pressed.emit()

func _on_quit_button_pressed() -> void:
	GUIBuss.quit_game.emit()


func _on_options_button_pressed() -> void:
	GUIBuss.menu_options_button_pressed.emit()


func _on_credits_pressed():
	GUIBuss.menu_credits_button_pressed.emit()


func _on_controls_pressed():
	GUIBuss.menu_buttons_button_pressed.emit()
