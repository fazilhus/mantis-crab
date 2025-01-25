class_name Bubble
extends Area3D

@onready var mesh = %BubbleMesh

var tween : Tween
var power: float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

static func create(bubblePosition: Node, chargeRate: float) -> Bubble:
	var bubble = preload("res://scenes/bubble.tscn").instantiate()
	bubblePosition.add_child(bubble)
	bubble.global_position = bubblePosition.global_position
	
	bubble.tween = bubble.create_tween()
	
	bubble.tween.tween_property(bubble.mesh, "scale", Vector3(1, 1, 1), 1/chargeRate)
	bubble.tween.parallel().tween_property(bubble, "power", 5, 1/chargeRate)
	
	
	return bubble	

func release():
	SignalBuss.bubble_release.emit(power)
	get_parent().remove_child(self)
	
	
func cancel():
	queue_free()
