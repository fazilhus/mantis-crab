class_name Level
extends Node3D

@onready var checkpoints_node : Node = %Checkpoints

var checkpoints : Array[Checkpoint] = []

var last_

func _ready():
	for child in checkpoints_node.get_children():
		var checkpoint : Checkpoint = child
		if checkpoint:
			checkpoints.push_back(checkpoint)

func _process(_delta):
	pass