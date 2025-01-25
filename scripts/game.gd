class_name Game
extends Node

@onready var level_manager : LevelManager = %LevelManager
@onready var player_manager : PlayerManager = %PlayerManager
@onready var respawn_timer : Timer = %Respawn_Timer

func _ready():
	GUIBuss.play_button_pressed.connect(_on_start_play)
	
	#TODO connect to GUI
	GUIBuss.play_button_pressed.emit()

	respawn_timer.timeout.connect(_on_respawn_timer_timeout)

func _process(_delta):
	pass

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ENTER:
			if respawn_timer.is_stopped():
				SignalBuss.player_died.emit()
				respawn_timer.start()
		

func _on_start_play() -> void:
	level_manager.start_first_level()

func _on_respawn_timer_timeout() -> void:
	SignalBuss.spawn_player.emit(level_manager.current_level, level_manager.current_level.last_activated_checkpoint.spawn_point)
	respawn_timer.stop()