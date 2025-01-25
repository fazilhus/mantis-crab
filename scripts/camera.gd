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
	global_position = target.camera_position
	global_rotation = target.camera_rotation

func _process(_delta):
	if target != null:
		self.rotation = target.camera_rotation + target.global_rotation
		if self.rotation.y < -2*PI + 0.001 or self.rotation.y > 2 * PI - 0.001:
			self.rotation.y = 0

		global_position = target.camera_position.rotated(Vector3.UP, target.global_rotation.y) + target.global_position
