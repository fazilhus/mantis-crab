extends Node3D

var amount_collected: int

	
func _ready() -> void:
	SignalBuss.collected_collectable.connect(handle_collectables)

func handle_collectables() -> void:
	amount_collected == amount_collected + 1
