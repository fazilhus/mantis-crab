extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	pass



func _on_body_exited(body:Node3D):
	if body is PlayerCharacter:
		body.apply_force(Vector3(500,0,0), body.global_position)


func _on_body_entered(body:Node3D):
	if body is PlayerCharacter:
		body.apply_force(Vector3(-500,0,0), body.global_position)
