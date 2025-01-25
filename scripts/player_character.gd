class_name PlayerCharacter
extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const AIR_RESISTANCE = 0.5
const STAMINA_MAX = 3

var shoot: Vector3
var bubble: Bubble
var stamina: int = STAMINA_MAX
var is_grabbing : bool = false
var can_grab : bool = false
@onready var camera_gimble = get_node("CameraGimble_Node3D")

func _ready():
	SignalBuss._can_grab.connect(_can_grab)
	SignalBuss.bubble_release.connect(on_bubble_release)

func _physics_process(delta: float) -> void:
	bubble_logic()
		
	if is_on_floor():
		ground_movement(delta)
	else:
		air_movement(delta)
	
	print(velocity)
	# Add the gravity.
	

	if can_grab and Input.is_action_just_pressed("Grab"):
		grab()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	move_and_slide()

func _unhandled_input(event: InputEvent):
	pass

func _can_grab():
	can_grab = true
	
func bubble_logic():
	if Input.is_action_just_pressed("Create_Bubble_Action") and stamina > 1:
		bubble = Bubble.create(%BubbleMarker, stamina)
		stamina -= 1
	if Input.is_action_just_released("Create_Bubble_Action") and bubble != null:
		bubble.release()
		bubble = null
	if is_on_floor():
		stamina = STAMINA_MAX
	
	velocity += shoot
	shoot.x = move_toward(shoot.x, 0, AIR_RESISTANCE)
	shoot.y = move_toward(shoot.y, 0, AIR_RESISTANCE)
	shoot.z = move_toward(shoot.z, 0, AIR_RESISTANCE)
	
func on_bubble_release(power: float):
	shoot = (%BubbleMarker.global_position - global_position) * power
	print(shoot)

func grab():
	#TODO tween a swinging motion and apply force
	pass

func air_movement(delta):
	velocity += get_gravity() * delta
	var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x += direction.x * SPEED / 2
		velocity.z += direction.z * SPEED / 2
	
	if direction.x * velocity.x < 0 :
		pass
	
func ground_movement(delta):
	if Input.is_action_just_pressed("Jump_Action"):
		velocity.y += 10
	
	var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = move_toward(velocity.x, direction.x * SPEED, 2) #sides
		velocity.z = move_toward(velocity.z, direction.z * SPEED, 2) #forward & backward
	else:
		velocity.x = move_toward(velocity.x, 0, 1)
		velocity.z = move_toward(velocity.z, 0, 1)
	
