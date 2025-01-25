class_name Game
extends Node

@onready var level_manager : LevelManager = %LevelManager
@onready var player_manager : PlayerManager = %PlayerManager

func _ready():
	GUIBuss.play_button_pressed.connect(_on_start_play)

func _process(_delta):
	pass

func _on_start_play() -> void:
	level_manager.start_first_level()
