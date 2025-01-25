class_name OptionsMenu
extends Control

@onready var default_focus : Control = $Back

var master_bus = AudioServer.get_bus_index("Master")

func _on_back_pressed():
	GUIBuss.option_menu_back_button_pressed.emit()


func _on_h_slider_value_changed(value:float):
	AudioServer.set_bus_volume_db(master_bus, value)
	if value == 0:
		AudioServer.set_bus_mute(master_bus, true)
	else:
		AudioServer.set_bus_mute(master_bus, false)


func _on_check_box_toggled(toggled_on:bool):
	AudioServer.set_bus_mute(master_bus, toggled_on)


func _on_check_button_toggled(toggled_on:bool):
	AudioServer.set_bus_mute(master_bus, toggled_on)
