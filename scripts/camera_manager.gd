class_name CameraManager
extends Node

@onready var main_camera : Camera = %MainCamera

func _ready():
	SignalBuss.player_spawned.connect(_on_player_spawned)
	SignalBuss.player_died.connect(_on_player_died)

func _process(_delta):
	pass

func _on_player_spawned(player: PlayerCharacter) -> void:
	player.camera_gimble.add_child(Camera3D.new())
	
	
func _on_player_died() -> void:
	main_camera.target = null
