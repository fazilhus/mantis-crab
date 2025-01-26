class_name CreditsMenu
extends Control

@onready var default_focus : Control = %Back

func _on_back_pressed():
	GUIBuss.credits_back_pressed.emit()
