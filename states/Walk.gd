extends State
class_name Walk

@export var character: CharacterBody3D
@export var move_speed := 10.9
var input_dir: Vector2
var move_direction: Vector3

var is_walking: bool

func Enter():
	# Reset variables
	input_dir = Vector2.ZERO
	move_direction = Vector3.ZERO
	print("Entered Walk State")
	
func Exit():
	character.velocity.x = move_toward(character.velocity.x, 0, move_speed)
	
func Update(_delta: float):
	if character.is_on_floor():
		if move_direction.length() == 0:
			Transitioned.emit(self, "Idle")
		elif Input.is_action_just_pressed("ui_accept"):
			Transitioned.emit(self, "Jump")
	elif !character.is_on_floor():
		Transitioned.emit(self, "Fall")
		
	if move_direction:
		character.flip_mesh()
	
func Physics_Update(_delta: float):
	input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	move_direction = (character.transform.basis * Vector3(input_dir.x, 0, 0)).normalized()
	
	if move_direction:
		character.velocity.x = move_direction.x * move_speed
		character.velocity.z = move_direction.z * move_speed
