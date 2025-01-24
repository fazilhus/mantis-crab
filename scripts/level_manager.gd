class_name LevelManager
extends Node

@export var first_level_pkd : PackedScene

var first_level : Level = null

@onready var current_level : Level = null

func _ready():
	SignalBuss.level_ready.connect(_on_level_ready)
	

func _process(_delta):
	pass

func start_first_level() -> void:
	first_level = first_level_pkd.instantiate()
	add_child(first_level)
	

func _on_level_ready(level: Level) -> void:
	current_level = level
	SignalBuss.spawn_player.emit(current_level.last_activated_checkpoint.spawn_point)
