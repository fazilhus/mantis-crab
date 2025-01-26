class_name ButtonMapMenu
extends Control

@onready var default_focus : Control = %Back

func _unhandled_input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		_on_back_pressed()

func _on_back_pressed():
	GUIBuss.buttons_back_pressed.emit()
