class_name CameraManager
extends Node

@onready var main_camera : Camera = %MainCamera

func _ready():
	SignalBuss.player_spawned.connect(_on_player_spawned)
	SignalBuss.player_died.connect(_on_player_died)

func _process(_delta):
	pass

func _on_player_spawned(player: PlayerCharacter) -> void:
	if main_camera.initialized:
		main_camera.target = player.camera_gimble
		return
	
	main_camera.init_camera(player.camera_gimble)

func _on_player_died() -> void:
	main_camera.target = null