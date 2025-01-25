class_name Camera
extends Camera3D

@export var speed : float = 4.8

var target : CameraGimble = null
var initialized : bool = false

func _ready():
	pass

func init_camera(gimble : CameraGimble) -> void:
	target = gimble
	initialized = true
	global_position = target.global_position
	global_rotation = target.global_rotation

func _process(delta):
	if target != null:
		global_position = lerp(global_position, target.global_position, delta * speed)
		global_rotation = lerp(global_rotation, target.global_rotation, delta * speed)
