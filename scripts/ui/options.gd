class_name OptionsMenu
extends Control

@onready var default_focus : Control = %ResumeButton

var master_bus = AudioServer.get_bus_index("Master")


func _on_check_box_toggled(toggled_on:bool):
	AudioServer.set_bus_mute(master_bus, toggled_on)


func _on_check_button_toggled(toggled_on:bool):
	AudioServer.set_bus_mute(master_bus, toggled_on)


func _on_resume_button_pressed():
	GUIBuss.option_menu_back_button_pressed.emit()
