extends Control

@onready var pause_menu = $PauseMenu
var paused = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.



func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/in game options.tscn")

func _process(delta):
	if Input.is_action_just_pressed("pausse"):
		pausemenu()

func pausemenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.shown()
		Engine.time_scale =0 
	
	paused = !paused
