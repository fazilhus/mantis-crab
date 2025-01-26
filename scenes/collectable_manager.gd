extends Node3D

var amount_collected: int
	
func _ready() -> void:
	SignalBuss.collected_collectable.connect(handle_collectables)
	SignalBuss.level_ready.connect(reset_collectables)

func handle_collectables() -> void:
	amount_collected = amount_collected + 1
	SignalBuss.emit_signal("collected_amount", amount_collected)
	
func reset_collectables() -> void:
	amount_collected = 0
	SignalBuss.emit_signal("collected_amount", amount_collected)
