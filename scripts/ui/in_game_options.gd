extends Control

var master_bus = AudioServer.get_bus_index("Master")

# Called when the node enters the scene tree for the first time.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_resume_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_check_box_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0,toggled_on)


func _on_check_button_toggled(toggled_on: bool) -> void:
	%StopwatchLabel2.visible = true









func _on_h_slider_value_changed(value): 
	AudioServer.set_bus_volume_db(master_bus, value)
	if value == 0:
		AudioServer.set_bus_mute(master_bus, true)
	else:
		AudioServer.set_bus_mute(master_bus, false)
