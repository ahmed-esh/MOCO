extends Node2D

@export var walk_speed = 50.0
@export var rotation_speed = 2.0

var look_angle : float = 0
var target_angle : float = 0
var curr_speed = 0.0
var input = Vector2.ZERO

var bob_offset = 0.0
var delta_sum = 0.0

func _process(delta):
	delta_sum += delta
	input = Vector2.ZERO
	input.x = Input.get_axis("left", "right")
	input.y = Input.get_axis("up", "down")
	
	input = input.normalized().rotated(Globals.Rotation)
	
	curr_speed = lerp(curr_speed, walk_speed, 10.0 * delta)
	position += input.normalized() * curr_speed * delta
	
	$Stack.bob_offset = bob_offset
	
	if input != Vector2.ZERO:
		bob_offset = sin(delta_sum * 15.0) * 1.5
		target_angle = input.angle()
		if abs(target_angle - look_angle) > (PI / 2):
			if target_angle > look_angle:
				target_angle -= PI * 2
			else:
				target_angle += PI * 2
	else:
		curr_speed = lerp(curr_speed, 0.0, 10.0 * delta)
	
	look_angle = lerp(look_angle, target_angle, 10.0 * delta)
	$Stack.set_stack_rotation(look_angle + PI/2)
	
	if Input.is_action_pressed("rotate_left"):
		Globals.Rotation += rotation_speed * delta
		$Camera2D.rotation = Globals.Rotation
	if Input.is_action_pressed("rotate_right"):
		Globals.Rotation -= rotation_speed * delta
		$Camera2D.rotation = Globals.Rotation
