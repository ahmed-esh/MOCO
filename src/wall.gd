extends Node2D

@export var wall_color : Color = Color.WHITE
@export var top_color : Color = Color.WHITE
@export var height : int = 10


func _ready():
	$Line2D.hide()
	spawn_lines()

func spawn_lines():
	for i in range(0, height):
		var next_line : Line2D = $Line2D.duplicate()
		$Walls.add_child(next_line)
		next_line.position = Vector2(0, -i)
		next_line.default_color = wall_color
		if i == height - 1:
			next_line.default_color = top_color
		next_line.show()
	
