extends State
class_name Fall_State

@export var character: CharacterBody3D

func Enter():
	print("Entered Fall State")
	
func Exit():
	pass
	
func Update(_delta: float):
	if character.is_on_floor():
		Transitioned.emit(self, "idle")
	
func Physics_Update(_delta: float):
	character.velocity.y -= character.gravity * _delta
