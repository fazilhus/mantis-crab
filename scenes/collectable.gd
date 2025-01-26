class_name Collectable
extends Area3D
var tween: Tween
var distance: Vector3
var origin: Vector3

func _ready() -> void:
	distance = self.position+Vector3(0,1,0)
	origin = self.position

func _process(delta: float) -> void:
	rotate_y(0.01)
	#position = Vector3(position.x, Tween, position.z)
	tween = create_tween()
	if self.position == distance:
		tween.tween_property(self, "position", origin, 2)
	if self.position == origin:
		tween.tween_property(self, "position", distance, 2)

func _on_body_entered(body: Node3D) -> void:
	$collectablesound.play()
	%MeshInstance3D.visible = false
	$CollisionShape3D.set_deferred("disabled", true) 

func _on_collectablesound_finished() -> void:
	SignalBuss.collected_collectable.emit()
	queue_free()
