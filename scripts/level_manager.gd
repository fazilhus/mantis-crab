class_name LevelManager
extends Node

@export var first_level_pkd : PackedScene
var first_level : Level = null
@onready var current_level : Level = null

var timer : float
var levelstarted : bool = false

func _ready():
	SignalBuss.level_ready.connect(_on_level_ready)
	SignalBuss.levelFinished.connect(_finishedlevel)
	
func _process(delta: float) -> void:
	if levelstarted:
		timer += delta

func start_first_level() -> void:
	first_level = first_level_pkd.instantiate()
	add_child(first_level)
	

func _on_level_ready(level: Level) -> void:
	current_level = level
	SignalBuss.spawn_player.emit(current_level, current_level.last_activated_checkpoint.spawn_point)
	levelstarted = true
	timer = 0

func _despawn_level() -> void:
	first_level.queue_free()

func _finishedlevel():
	levelstarted = false
	SignalBuss.timeFinished.emit(timer)
