class_name Collectable
extends Area3D

func _process(delta: float) -> void:
	rotate_y(0.01)
	position = Vector3(position.x, sin(0.0), position.z)

func _on_body_entered(body: Node3D) -> void:
	$collectablesound.play()
	%MeshInstance3D.visible = false
	$CollisionShape3D.set_deferred("disabled", true) 

func _on_collectablesound_finished() -> void:
	SignalBuss.collected_collectable.emit()
	queue_free()
