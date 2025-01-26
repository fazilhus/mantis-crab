class_name Checkpoint
extends Node3D

@onready var spawn_point : SpawnPoint = %SpawnPoint

var activated : bool = false

func _ready() -> void:
	pass

func _process(_delta) -> void:
	pass

func trigger() -> void:
	SignalBuss.checkpoit_triggered.emit(self)
	activated = true

func _on_trigger_area_3d_body_entered(body:Node3D):
	if body is PlayerCharacter:
		trigger()
	
	if activated:
		return
