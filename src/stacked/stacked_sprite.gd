@tool
extends Sprite2D

var player_ref : Node2D = null

@onready var start_position : Vector2 = global_position
@onready var start_angle : float = global_position.angle()

var bob_offset = 0.0

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
	if player_ref and not Engine.is_editor_hint():
		update_stack_direction()

func update_stack_direction():
	if !has_node("Stack"):
		return
	for i in range(0, $Stack.get_child_count()):
		var camera_rotation = 0.0 if Engine.is_editor_hint() else Globals.Rotation
		var next_sprite = $Stack.get_child(i)
		var start_offset = Vector2.UP.rotated(camera_rotation)
		var bob = Vector2.UP.rotated(camera_rotation) * bob_offset
		next_sprite.position = Vector2.UP.rotated(camera_rotation) * i + bob

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
