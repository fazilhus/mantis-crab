class_name Checkpoint
extends Node3D

@onready var spawn_point : SpawnPoint = %SpawnPoint

func _ready() -> void:
	pass

func _process(_delta) -> void:
	pass

func trigger() -> void:
	print("Checkpoint triggered")

func _on_trigger_area_3d_body_entered(body:Node3D):
	var player : PlayerCharacter = body
	if !player:
		return
	
	trigger()
