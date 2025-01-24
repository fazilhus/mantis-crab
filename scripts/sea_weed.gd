extends Node3D
class_name SeaWeed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass	 

func _on_area_3d_body_exited(body:Node3D):
	var parent = body.get_parent()
	if parent is Crab:
		var crab := parent as Crab
		if crab.is_grabbing:
			return
		crab.can_grab = false		
	
func _on_area_3d_body_entered(_body:Node3D):
	SignalBuss._can_grab.emit()
