class_name ButtonMapMenu
extends Control

@onready var default_focus : Control = %Back

func _on_back_pressed():
	GUIBuss.buttons_back_pressed.emit()
