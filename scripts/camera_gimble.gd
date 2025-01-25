class_name CameraGimble
extends Node3D

@export var camera_position : Vector3
@export var camera_rotation : Vector3

func _ready():
	$Camera3D.position = camera_position
	$Camera3D.rotation = camera_rotation

func _process(_delta):
	pass
