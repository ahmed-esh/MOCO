@tool
extends Sprite2D

var player_ref : Node2D = null

@onready var start_position : Vector2 = position

@export var stack_texture : Texture2D = null :
	set(value):
		stack_texture = value
		hframes = stack_texture.get_width() / sprite_width
		setup_stack()

@export var sprite_width : float = 16 :
	set(value):
		sprite_width = value
		if stack_texture:
			hframes = stack_texture.get_width() / sprite_width
		setup_stack()

@export_range(0.0, 3.14) var stack_rotation : float = 0.0 :
	set(value):
		stack_rotation = value
		set_stack_rotation(stack_rotation)

func _ready():
	setup_stack()
	var player_check = get_tree().get_first_node_in_group("Player")
	if player_check:
		player_ref = player_check

func _process(delta):
	if not has_node("Stack"):
		return
	if $Stack.get_child_count() == 0:
		setup_stack()
	if player_ref:
		update_position_to_player()
		update_stack_camera_angle()

func update_position_to_player():
	if not player_ref or not find_child("Stack"):
		return
	var player_position = player_ref.position
	var distance_to_player = position.distance_to(player_position)
	var angle_from_player_to_stack = player_position.angle_to(position)
	var updated_angle = angle_from_player_to_stack + Globals.Rotation
	var updated_position = player_ref.position + Vector2(cos(updated_angle), sin(updated_angle)) * distance_to_player
	position = updated_position

func update_stack_camera_angle():
	if not player_ref or not find_child("Stack"):
		return
	for i in range(0, hframes):
		var next_child = $Stack.get_child(i)
		var next_x = cos(Globals.Rotation)
		var next_y = sin(Globals.Rotation)
		next_child.position = Vector2(next_x, next_y) * i

func set_stack_rotation(rot):
	if not has_node("Stack"):
		return
	for stack : Sprite2D in $Stack.get_children():
		stack.rotation = rot

func delete_stack():
	if not has_node("Stack"):
		return
	for sprite in $Stack.get_children():
		sprite.queue_free()

func setup_stack():
	if not has_node("Stack"):
		return
	delete_stack()
	for i in range(0, hframes):
		var next_sprite = Sprite2D.new()
		$Stack.add_child(next_sprite)
		next_sprite.texture = stack_texture
		next_sprite.hframes = hframes
		next_sprite.frame = i
		next_sprite.position = Vector2(0, -i)
	set_stack_rotation(stack_rotation)
