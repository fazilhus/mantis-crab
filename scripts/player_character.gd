class_name PlayerCharacter
extends CharacterBody3D

@onready var camera_gimble : CameraGimble = %CameraGimble
@onready var animTree: AnimationTree = %AnimationTree

const SPEED = 12.0
const JUMP_VELOCITY = 4.5
const AIR_RESISTANCE = 0.5
const STAMINA_MAX = 3

var was_in_air: bool = false
var mouse_hidden: bool = false
var shoot: Vector3
var bubble: Bubble
var stamina: int = STAMINA_MAX
var is_grabbing : bool = false
var can_grab : bool = false

var current_dir : Vector3 = Vector3.ZERO

var camera_gimble_origin : Vector3 = Vector3.ZERO
var camera_gimble_rotation_origion : Vector3 = Vector3.ZERO

var lastMousePosition : Vector2 = Vector2.ZERO
var rotation_speed : Vector2 = Vector2.ZERO
@export var rot_speed_mod : Vector2 = Vector2.ONE

func _ready():
	SignalBuss._can_grab.connect(_can_grab)
	SignalBuss.bubble_release.connect(on_bubble_release)
	camera_gimble_origin = camera_gimble.position
	SignalBuss.current_entered.connect(on_current_entered)

	SignalBuss.player_spawned.emit(self)
	
	GUIBuss.pause_menu_resume_button_pressed.connect(hide_mouse_again)
	
func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		if mouse_hidden:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _physics_process(delta: float) -> void:
	bubble_logic()
	
	if is_on_floor():
		if was_in_air:
			animTree.set("parameters/Land/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
			was_in_air = false
		ground_movement(delta)
	else:
		was_in_air = true
		air_movement(delta)
	#if current_dir is not Vector3.ZERO:

	self.velocity += 1.5*current_dir
		
	# Add the gravity.
	

	if can_grab and Input.is_action_just_pressed("Grab"):
		grab()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	self.rotation.y = self.rotation.y + 1 * rotation_speed.y * rot_speed_mod.y * delta
	camera_gimble.rotation.x = camera_gimble.rotation.x + 1 * rotation_speed.x * rot_speed_mod.x * delta

	camera_gimble.rotation.x = clampf(camera_gimble.rotation.x, -0.5, 0.5)

	if self.rotation.y < -2*PI + 0.001 or self.rotation.y > 2 * PI - 0.001:
		self.rotation.y = 0
	rotation_speed = Vector2.ZERO

	move_and_slide()
	
	if Input.is_action_just_pressed("Hide_Mouse"):
		if mouse_hidden:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			mouse_hidden = false
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			mouse_hidden = true
	
	
func _unhandled_input(event: InputEvent):
	if event is InputEventJoypadMotion:
		rotation_speed = Input.get_vector("Camera_Up", "Camera_Down", "Camera_Left", "Camera_Right")
		rotation_speed *= -1
	
	
func _input(event):
	if event is InputEventMouseMotion and mouse_hidden:
		var delta : Vector2
		if lastMousePosition != Vector2.ZERO:
			delta = event.relative
		lastMousePosition = event.relative
		rotation_speed.x = -delta.y
		rotation_speed.y = -delta.x

func _can_grab():
	can_grab = true
	
func bubble_logic():
	if Input.is_action_just_pressed("Create_Bubble_Action") and stamina > 1:
		animTree.set("parameters/Charge/blend_amount", 1.0)
		bubble = Bubble.create(%BubbleMarker, stamina)
		stamina -= 1
	if Input.is_action_just_released("Create_Bubble_Action") and bubble != null:
		animTree.set("parameters/Charge/blend_amount", 0.0)
		animTree.set("parameters/Punch/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
		bubble.release()
		bubble = null
	if is_on_floor():
		stamina = STAMINA_MAX
	
func on_bubble_release(power: float):
	bubble = null
	velocity = (%BubbleMarker.global_position - global_position) * power

func grab():
	#TODO tween a swinging motion and apply force
	pass

func air_movement(delta):
	animTree.set("parameters/Walk_Air_Punch/transition_request", "AirBorne")
	
	if velocity.y >= 0:
		velocity += get_gravity() * delta * 2.5
	else:
		velocity += get_gravity() * delta * 5
		
	var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x += direction.x * SPEED / 30
		velocity.z += direction.z * SPEED / 20
	
	if velocity.x <= -10 or velocity.x >= 10:
		velocity.x = move_toward(velocity.x, 0, 0.7)
	
	if velocity.z <= -10 or velocity.z >= 10:
		velocity.z = move_toward(velocity.z, 0, 0.7)
	
	
func ground_movement(delta):
	animTree.set("parameters/Walk_Air_Punch/transition_request", "Idle_Walk")
	
	if Input.is_action_just_pressed("Jump_Action"):
		animTree["parameters/Jump/request"] = AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE
		velocity.y += 8
		#velocity.x *= 1.2
		#velocity.z *= 1.2
	
	var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = move_toward(velocity.x, direction.x * SPEED, 2) #sides
		velocity.z = move_toward(velocity.z, direction.z * SPEED, 2) #forward & backward
	else:
		velocity.x = move_toward(velocity.x, 0, 1)
		velocity.z = move_toward(velocity.z, 0, 1)
	
	animTree.set("parameters/Idle_Walk/blend_amount", clampf(abs(velocity.length()), 0, 1))
	print(animTree.get("parameters/Idle_Walk/blend_amount"))
	
func hide_mouse_again():
	if mouse_hidden:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func on_current_entered(current_direction: Vector3):
	current_dir = current_direction
	
