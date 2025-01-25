extends Area3D
class_name current

var entered : bool = false
var exited : bool = false
@onready var stream_End_marker : Marker3D = %Stream_End
var current_force_direction : Vector3 = Vector3.ZERO
var player : PlayerCharacter

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	# if entered:
	# 	player.velocity.x = move_toward(player.velocity.x, current_force_direction.x, 4)
	# 	player.velocity.y = move_toward(player.velocity.y, current_force_direction.y, 4)
	# 	player.velocity.z = move_toward(player.velocity.z, current_force_direction.z, 4)

	# 	player.move_and_slide()

	# if exited:
	# 	player.velocity.x = move_toward(player.velocity.x, current_force_direction.x, 4)
	# 	player.velocity.y = move_toward(player.velocity.y, current_force_direction.y, 4)
	# 	player.velocity.z = move_toward(player.velocity.z, current_force_direction.z, 4)

	# 	player.move_and_slide()
	# 	exited = false
	pass
		

func _on_body_exited(body:Node3D):
	if body is PlayerCharacter:
		player = body
		SignalBuss.current_entered.emit(Vector3.ZERO)


func _on_body_entered(body:Node3D):
	if body is PlayerCharacter:
		player = body
		SignalBuss.current_entered.emit((stream_End_marker.global_position-player.global_position).normalized())
	# 	entered = true
	# 	exited = false
	# 	current_force_direction = 0.2*(stream_End_marker.global_position-player.global_position).normalized()
