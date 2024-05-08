extends CharacterBody3D

const SPEED = 10.9
const JUMP_VELOCITY = 7.607
var jump_held = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 15.236
var is_jumping = false
var is_walking = false
#var is_falling = false
#var is_landing = false
var is_run_jumping = false
var jump_modifier = 0

@onready var mesh: MeshInstance3D = $CollisionShape3D/MeshInstance3D

func _physics_process(delta):
	# Add the gravity.		
	#if is_falling():
		#velocity.y -= gravity * delta
	velocity.y -= gravity * delta
			
	# Handle jump.	
	#if Input.is_action_pressed("ui_accept") and can_jump():
		#is_jumping = true
		#jump_held += delta
		#
		#jump_modifier = jump_held * 10
#
		#velocity.y = JUMP_VELOCITY
			#
	#if Input.is_action_just_released("ui_accept"):
		#is_jumping = false
	#
	#if is_on_floor():
		#jump_held = 0
		#if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
			#is_walking = true
	#else:
		#is_walking = false

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

func flip_mesh():
	if velocity.x > 0:
		mesh.rotation_degrees = Vector3(0, 0, 0)
	if velocity.x < 0:
		mesh.rotation_degrees = Vector3(0, 180, 0)

func jump_mesh(delta):
	var wide = 50
	var thin = 0.5
	#move_toward(1, wide, delta)
	$CollisionShape3D.scale = Vector3(move_toward(1, wide, delta), move_toward(1, wide, delta), move_toward(1, wide, delta)) 
	
func idle_mesh():
	$CollisionShape3D.scale = Vector3.ONE
	
func land_mesh():
	$CollisionShape3D.scale = Vector3(1.5, 0.5, 1.5)
