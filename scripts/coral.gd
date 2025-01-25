extends Node3D
class_name Coral

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_area_3d_body_entered(body:Node3D):
		#TODO Update statement to check for bubble
	if body.get_parent() is PlayerCharacter:
		#Break animation
		#Break sound
		self.queue_free()
