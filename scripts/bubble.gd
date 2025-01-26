class_name Bubble
extends Area3D

signal entered_coral_range(entered: bool)

@onready var FX_Implosion = preload("res://scenes/FX_Implosion.tscn")

@onready var mesh = %BubbleMesh

const MAX_POWER = 10

var in_coral: bool = false
var tween : Tween
var power: float
var parent: Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	entered_coral_range.connect(on_entered_coral_range)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if in_coral and power > 7:
		release()
		

static func create(bubblePosition: Node3D, chargeRate: float) -> Bubble:
	var bubble = preload("res://scenes/bubble.tscn").instantiate()
	bubblePosition.add_child(bubble)
	bubble.parent = bubblePosition
	bubble.global_position = bubblePosition.global_position
	
	bubble.tween = bubble.create_tween()
	
	bubble.tween.tween_property(bubble.mesh, "scale", Vector3(1.5, 1.5, 1.5), (1/chargeRate)*3)
	bubble.tween.parallel().tween_property(bubble, "power", MAX_POWER, (1/chargeRate)*3)
	return bubble	

func release():
	if not in_coral:
		SignalBuss.bubble_release.emit(power)
		
		var implosion_instance = FX_Implosion.instantiate()
		parent.add_child(implosion_instance)
		implosion_instance.global_position = parent.global_position
		queue_free()
	else:
		SignalBuss.bubble_release.emit(0)
		queue_free()
		
	
	
func on_entered_coral_range(entered: bool):
	in_coral = entered
