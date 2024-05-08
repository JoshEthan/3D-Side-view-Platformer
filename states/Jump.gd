extends State
class_name Jump

@export var character: CharacterBody3D

func Enter():
	print("Entered Jump State")
	
func Exit():
	pass
	
func Update(_delta: float):
	character.jump_mesh(_delta)
	if character.is_on_floor():
		if Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
			Transitioned.emit(self, "Walk")
		if Input.is_action_just_pressed("ui_accept"):
			Transitioned.emit(self, "Jump")
	elif !character.is_on_floor():
		Transitioned.emit(self, "Fall")
	
	
func Physics_Update(_delta: float):
	pass
