class_name Level
extends Node3D

@onready var checkpoints_node : Node = %Checkpoints

var checkpoints : Array[Checkpoint] = []

var last_activated_checkpoint : Checkpoint

func _ready():
	for child in checkpoints_node.get_children():
		var checkpoint : Checkpoint = child
		if checkpoint:
			checkpoints.push_back(checkpoint)

	last_activated_checkpoint = checkpoints.front()
	_on_ready()

func _process(_delta):
	pass

func _on_ready():
	SignalBuss.level_ready.emit(self)
