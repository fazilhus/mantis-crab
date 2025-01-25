class_name Game
extends Node

@onready var level_manager : LevelManager = %LevelManager
@onready var player_manager : PlayerManager = %PlayerManager
@onready var respawn_timer : Timer = %Respawn_Timer

var paused : bool = false
var playing : bool = false

func _ready():
	GUIBuss.play_button_pressed.connect(_on_start_play)
	GUIBuss.pause_menu_resume_button_pressed.connect(_on_pause_menu_resume_button_pressed)
	GUIBuss.pause_menu_home_button_pressed.connect(_on_pause_menu_home_button_pressed)
	GUIBuss.quit_game.connect(_on_quit_game)
	
	respawn_timer.timeout.connect(_on_respawn_timer_timeout)
	
	GUIBuss.game_started.emit()

func _process(_delta):
	if Input.is_action_just_pressed("Pause"):
		if playing:
			GUIBuss.pause_game.emit()
			pause_game()

func _on_start_play() -> void:
	level_manager.start_first_level()
	playing = true
	GUIBuss.level_started.emit()

func _on_quit_game() -> void:
	get_tree().free()

func _on_respawn_timer_timeout() -> void:
	SignalBuss.spawn_player.emit(level_manager.current_level, level_manager.current_level.last_activated_checkpoint.spawn_point)
	respawn_timer.stop()

func _on_pause_menu_resume_button_pressed() -> void:
	unpause_game()

func _on_pause_menu_home_button_pressed() -> void:
	level_manager._despawn_level()
	playing = false

func pause_game() -> void:
	paused = true
	get_tree().paused = true

func unpause_game() -> void:
	paused = false
	get_tree().paused = false
