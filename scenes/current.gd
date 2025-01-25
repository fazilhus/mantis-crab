extends Area3D
class_name current

var entered : bool = false
var exited : bool = false
var player : PlayerCharacter
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if entered:
		player.velocity.x = move_toward(player.velocity.x, 8, 4)
		player.move_and_slide()
	if exited:
		player.velocity.x = move_toward(player.velocity.x, -8, 4)
		player.move_and_slide()
		exited = false
		
	
	



func _on_body_exited(body:Node3D):
	if body is PlayerCharacter:
		player = body
		entered = false
		exited = true
		print("should move")
		#body.apply_force(Vector3(500,0,0), body.global_position)


func _on_body_entered(body:Node3D):
	if body is PlayerCharacter:
		player = body
		entered = true
		print("should move")
		# body.velocity.x = move_toward(body.velocity.x, 5, 2)
		# body.move_and_slide()
		#body.apply_force(Vector3(-500,0,0), body.global_position)
