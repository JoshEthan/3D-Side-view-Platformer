extends State
class_name Idle

@export var character: CharacterBody3D
var move_direction: Vector2

func Enter():
	print("Entered Idle State")
	
func Exit():
	pass
	
func Update(_delta: float):
	character.idle_mesh(_delta)
	if character.is_on_floor():
		if Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
			Transitioned.emit(self, "walk")
		if Input.is_action_just_pressed("ui_accept"):
			Transitioned.emit(self, "jump")
	elif !character.is_on_floor():
		Transitioned.emit(self, "fall_state")
	
func Physics_Update(_delta: float):
	pass
