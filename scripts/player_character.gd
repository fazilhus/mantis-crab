class_name PlayerCharacter
extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const AIR_RESISTANCE = 2
const STAMINA_MAX = 3

var shoot: Vector3
var bubble: Bubble
var stamina: int = STAMINA_MAX
var is_grabbing : bool = false
var can_grab : bool = false
@onready var camera_gimble = get_node("CameraGimble_Node3D")
var camera_gimble_origin : Vector3 = Vector3.ZERO
var camera_gimble_rotation_origion : Vector3 = Vector3.ZERO

var rotation_speed : Vector2 = Vector2.ZERO
@export var rot_speed_mod : Vector2 = Vector2.ONE

func _ready():
	SignalBuss._can_grab.connect(_can_grab)
	SignalBuss.bubble_release.connect(on_bubble_release)
	camera_gimble_origin = camera_gimble.position

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if can_grab and Input.is_action_just_pressed("Grab"):
		grab()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	#if abs(rotation_speed.x) > 0.3:
	#	rotation.y = rotate_toward(rotation.y, rotation.y - 1 * rotation_speed.x, delta)

	print(rotation_speed.y)
	# if abs(rotation_speed.y) > 0.3 and camera_gimble.rotation.y > -0.5 and camera_gimble.rotation.y <= 0:
	# 	camera_gimble.rotation.y = rotate_toward(camera_gimble.rotation.y, camera_gimble.rotation.y + 1 * rotation_speed.y, delta)
	# 	camera_gimble.position.z = move_toward(camera_gimble.position.z,self.position.z,delta*6)	
	#if rotation_speed.y > -0.3 and rotation_speed.y != 0:
		#camera_gimble.position.z = move_toward(camera_gimble.position.z,self.position.z,delta*4)
	camera_gimble.rotation.x = camera_gimble.rotation.x + 1 * rotation_speed.x * rot_speed_mod.x * delta
	camera_gimble.rotation.y = camera_gimble.rotation.y + 1 * rotation_speed.y * rot_speed_mod.y * delta
	#else:
		#pass
		#camera_gimble.rotation.y = rotate_toward(camera_gimble.rotation.y, camera_gimble_rotation_origion.x + 1 * rotation_speed.y, delta)
		#camera_gimble.position.z = move_toward(camera_gimble.position.z,camera_gimble_origin.z,delta*8)

	camera_gimble.rotation.x = clampf(camera_gimble.rotation.x, -0.5, 0.3)
	camera_gimble.rotation.y = clampf(camera_gimble.rotation.y, -0.8, 0.8)
	
	bubble_logic()
	
	move_and_slide()
	

func _unhandled_input(event: InputEvent):
	if event is InputEventJoypadMotion:
		rotation_speed = Input.get_vector("Camera_Down", "Camera_Up", "Camera_Right", "Camera_Left")
		rotation_speed *= -1

	
	

func _can_grab():
	can_grab = true
	
func bubble_logic():
	if Input.is_action_just_pressed("ui_accept") and stamina > 1:
		bubble = Bubble.create(self, stamina)
		stamina -= 1
	if Input.is_action_just_released("ui_accept") and bubble != null:
		bubble.release()
		bubble = null
	if is_on_floor():
		stamina = STAMINA_MAX
	
	velocity += shoot
	shoot.x = move_toward(shoot.x, 0, AIR_RESISTANCE)
	shoot.y = move_toward(shoot.y, 0, AIR_RESISTANCE)
	shoot.z = move_toward(shoot.z, 0, AIR_RESISTANCE)
	
func on_bubble_release(power: float):
	shoot = Vector3(0,1,1) * power

func grab():
	#TODO tween a swinging motion and apply force
	pass
