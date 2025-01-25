extends Control

func _on_play_button_2_pressed():
	GUIBuss.play_button_pressed.emit()

func _on_quit_button_pressed() -> void:
	GUIBuss.quit_game.emit()


func _on_options_button_2_pressed():
	GUIBuss.menu_options_button_pressed.emit()


func _on_quit_button_2_pressed():
	GUIBuss.quit_game.emit()
