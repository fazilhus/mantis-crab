class_name PlayerManager
extends Node

@export var player_pkd : PackedScene
var player : PlayerCharacter = null

func _ready() -> void:
	SignalBuss.spawn_player.connect(_on_spawn_player)
	SignalBuss.player_died.connect(_on_player_died)

func _process(_add_ice_candidatedelta) -> void:
	pass

func _on_spawn_player(root: Node, spawn_point: SpawnPoint) -> void:
	if player != null:
		player.queue_free()
	
	player = player_pkd.instantiate()
	player.position = spawn_point.global_position
	root.add_child(player)

func _on_player_died() -> void:
	if player == null:
		return
	
	player.queue_free()
