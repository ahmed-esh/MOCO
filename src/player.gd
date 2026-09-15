extends Node2D

@export var walk_speed = 75.0
@export var rotation_speed = 2.0

func _process(delta):
	var input = Vector2.ZERO
	input.x = Input.get_axis("left", "right")
	input.y = Input.get_axis("up", "down")
	
	position += input.normalized() * walk_speed * delta
	
	if Input.is_action_pressed("rotate_left"):
		Globals.Rotation += rotation_speed * delta
	if Input.is_action_pressed("rotate_right"):
		Globals.Rotation -= rotation_speed * delta
