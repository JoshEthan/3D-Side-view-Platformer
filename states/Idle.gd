extends State
class_name Idle

@export var character: CharacterBody3D
var move_direction: Vector2

func Enter():
	print("Entered Idle State")
	
func Exit():
	pass
	
func Update(_delta: float):
	if character.is_on_floor():
		if Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
			Transitioned.emit(self, "Walk")
		if Input.is_action_just_pressed("ui_accept"):
			Transitioned.emit(self, "Jump")
	elif !character.is_on_floor():
		Transitioned.emit(self, "Fall")
	
func Physics_Update(_delta: float):
	pass
