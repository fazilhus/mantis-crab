extends Control

@onready var pause_menu = %Panel2
var paused = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.



func _on_options_pressed() -> void:
	pass

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pausemenu()

func pausemenu():
	if paused:
		pause_menu.visible = false
		Engine.time_scale = 1
	else:
		pause_menu.visible = true
		Engine.time_scale = 0 
	
	paused = !paused


func _on_options_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/in game options.tscn")





func _on_home_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/Main Menu.tscn")
