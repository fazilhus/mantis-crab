class_name Collectable
extends Area3D

func _process(delta: float) -> void:
	rotate_y(0.01)


func _on_body_entered(body: Node3D) -> void:
	$collectablesound.play()
	$MeshInstance3D.queue_free()


func _on_collectablesound_finished() -> void:
	SignalBuss.collected_collectable.emit(self)
	queue_free()
