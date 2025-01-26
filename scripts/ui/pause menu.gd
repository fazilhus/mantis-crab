class_name PauseMenu
extends Control

@onready var default_focus : Control = %Resume

func _ready() -> void:
	SignalBuss.collected_amount.connect(handle_bottle)
	
func _on_resume_pressed() -> void:
	GUIBuss.pause_menu_resume_button_pressed.emit()

func _on_options_pressed() -> void:
	GUIBuss.pause_menu_options_button_pressed.emit()

func _on_home_pressed() -> void:
	GUIBuss.pause_menu_home_button_pressed.emit()

func handle_bottle(amount: int) -> void:
	%collected_amount.text = "x " + str(amount)
