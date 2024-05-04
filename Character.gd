extends CharacterBody3D


const SPEED = 10.9
const JUMP_VELOCITY = 7.607
var jump_held = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 15.236
var is_jumping = false
var jump_modifier = 0

func _physics_process(delta):
	# Add the gravity.		
	if is_falling():
		velocity.y -= gravity * delta
			
	# Handle jump.	
	if Input.is_action_pressed("ui_accept") and can_jump():
		is_jumping = true
		jump_held += delta
		
		jump_modifier = jump_held * 10

		velocity.y = JUMP_VELOCITY
			
	if Input.is_action_just_released("ui_accept"):
		is_jumping = false
	
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
		is_jumping = false
		return false

func is_falling():
	if is_jumping or is_on_floor():
		return false
	elif !is_jumping and !is_on_floor():
		is_jumping = false
		return true
		

	
	
