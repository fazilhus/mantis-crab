class_name Bubble
extends Area3D

@onready var FX_Implosion = preload("res://scenes/FX_Implosion.tscn")

@onready var mesh = %BubbleMesh

const MAX_POWER = 2.5

var tween : Tween
var power: float
var parent: Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

static func create(bubblePosition: Node3D, chargeRate: float) -> Bubble:
	var bubble = preload("res://scenes/bubble.tscn").instantiate()
	bubblePosition.add_child(bubble)
	bubble.parent = bubblePosition
	bubble.global_position = bubblePosition.global_position
	
	bubble.tween = bubble.create_tween()
	
	bubble.tween.tween_property(bubble.mesh, "scale", Vector3(1.5, 1.5, 1.5), 1/chargeRate)
	bubble.tween.parallel().tween_property(bubble, "power", MAX_POWER, 1/chargeRate)
	
	
	return bubble	

func release():
	SignalBuss.bubble_release.emit(power)
	
	var implosion_instance = FX_Implosion.instantiate()
	parent.add_child(implosion_instance)
	implosion_instance.global_position = parent.global_position
	
	parent.remove_child(self)
	
	
func cancel():
	queue_free()
