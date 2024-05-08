extends State
class_name Jump

@export var character: CharacterBody3D

func Enter():
	print("Entered Jump State")
	
func Exit():
	pass
	
func Update(_delta: float):
	character.jump_mesh(_delta)
	if Input.is_action_just_released("ui_accept"):
		Transitioned.emit(self, "fall_state")
	
	
func Physics_Update(_delta: float):
	# Handle jump.	
	if Input.is_action_pressed("ui_accept"):
		#is_jumping = true
		#jump_held += delta
		
		#jump_modifier = jump_held * 10

		character.velocity.y = character.JUMP_VELOCITY
