extends Node3D
class_name Coral

@onready var fx = %GPUParticles3D
var timer : Timer
# Called when the node enters the scene tree for the first time.
func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.autostart = false
	timer.timeout.connect(self.queue_free)

func _on_area_3d_body_entered(body:Node3D):
		#TODO Update statement to check for bubble
	if body.get_parent() is PlayerCharacter:
		#Break animation
		#Break sound
		destroy(0)

func destroy(power: float):
	$MeshInstance3D.visible = false
	fx.emitting = true
	timer.start(fx.lifetime)
	%CrunchSound.play()

func _on_snap_area_3d_area_entered(area):
	if area is Bubble:
		area.entered_coral_range.emit(true)
		SignalBuss.bubble_release.connect(destroy)


func _on_snap_area_3d_area_exited(area):
	if area is Bubble:
		area.entered_coral_range.emit(false)
		SignalBuss.bubble_release.disconnect(destroy)
