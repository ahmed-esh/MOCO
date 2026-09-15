extends Node2D

@export var wall_color : Color = Color.WHITE
@export var top_color : Color = Color.WHITE
@export var height : int = 10

var player_ref : Node2D = null

func _ready():
	$Line2D.hide()
	spawn_lines()
	var player_check = get_tree().get_first_node_in_group("Player")
	if player_check:
		player_ref = player_check

func spawn_lines():
	for i in range(0, height):
		var next_line : Line2D = $Line2D.duplicate()
		$Walls.add_child(next_line)
		next_line.position = Vector2(0, -i)
		next_line.default_color = wall_color
		if i == height - 1:
			next_line.default_color = top_color
		next_line.show()
	
func _process(delta):
	if player_ref and not Engine.is_editor_hint():
		update_stack_direction()

func update_stack_direction():
	if !has_node("Walls"):
		return
	for i in range(0, $Walls.get_child_count()):
		var camera_rotation = 0.0 if Engine.is_editor_hint() else Globals.Rotation
		var next_sprite = $Walls.get_child(i)
		var start_offset = Vector2.UP.rotated(camera_rotation)
		next_sprite.position = Vector2.UP.rotated(camera_rotation) * i
