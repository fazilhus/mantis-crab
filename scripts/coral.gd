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

func destroy(power: float):
	queue_free()

func _on_snap_area_3d_area_entered(area):
	if area is Bubble:
		area.entered_coral_range.emit(true)
		SignalBuss.bubble_release.connect(destroy)


func _on_snap_area_3d_area_exited(area):
	if area is Bubble:
		area.entered_coral_range.emit(false)
		SignalBuss.bubble_release.disconnect(destroy)
