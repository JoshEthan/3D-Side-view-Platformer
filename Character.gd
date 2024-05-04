extends CharacterBody3D


const SPEED = 10.9
#const JUMP_VELOCITY = 7.607
const JUMP_VELOCITY = 5
const MAX_JUMP_TIME = 100
var jump_timer = 0
var jump_velocity = 2.5
var air_time = 0
var jump_held = 0
var max_air_time = 0
var JUMP_HEIGHT = 100

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 15.236
# Minimum Velocity for 2.5 meters
const min_jump_velocity = 8.73 /2
#Maximum Velocity for 10.5 meters:
const max_jump_velocity = 17.89
var t = 0  # Normalized time
var adjusted_t = 0  # Makes the curve accelerate faster

func _physics_process(delta):
	# Add the gravity.
	#if not is_on_floor():
		#air_time += delta
		#if air_time > max_air_time:
			#velocity.y -= gravity * delta
	#else:
		#air_time = 0
		
	if not is_on_floor():
		velocity.y -= gravity * delta
		air_time += delta
	else:
		air_time = 0
			
	# Handle jump.	
	if Input.is_action_pressed("ui_accept") and can_jump():
		jump_held += delta
		if jump_held >= 0.5:
			velocity.y = max_jump_velocity
		if jump_held < 0.5 and jump_held > 0.1:
			#velocity.y = ((max_jump_velocity - min_jump_velocity)/(0.5-0.1)) * (jump_held - 0.1) + 8.73
			t = (jump_held / 0.5)  # Normalized time
			adjusted_t = t ** (1/2)  # Makes the curve accelerate faster
			velocity.y = lerpf(min_jump_velocity, max_jump_velocity, adjusted_t)
		elif jump_held <= 0.1:
			velocity.y = min_jump_velocity
	
	if is_on_floor():
		jump_held = 0

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	
func can_jump():
	if jump_held < 0.5:
		return true
	elif jump_held > 0.5:
		return false
