extends Area3D
class_name current

var entered : bool = false
var exited : bool = false
@onready var stream_End_marker : Marker3D = %Stream_End
@onready var audio_streamer : AudioStreamPlayer3D = %CurrentAudioStreamPlayer
@export var current_force_multiplier : float = 1.0
var current_force_direction : Vector3 = Vector3.ZERO
var player : PlayerCharacter

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	pass
		

func _on_body_exited(body:Node3D):
	if body is PlayerCharacter:
		audio_streamer.play(0)
		player = body
		SignalBuss.current_entered.emit(Vector3.ZERO)


func _on_body_entered(body:Node3D):
	if body is PlayerCharacter:
		player = body
		SignalBuss.current_entered.emit(current_force_multiplier * (stream_End_marker.global_position-player.global_position).normalized())
	# 	entered = true
	# 	exited = false
	# 	current_force_direction = 0.2*(stream_End_marker.global_position-player.global_position).normalized()
