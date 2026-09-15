extends Line2D

@export var angle_offset : float = 0
@export var angle_distance : float = 5
@export var time_to_step : float = 1.0
@export var time_per_step = 2.0

var player_ref : Node2D = null
var freeze_step_position = Vector2.ZERO
var freeze_player_position = Vector2.ZERO

func _ready():
	player_ref = get_parent().get_parent()
	freeze_step_position = points[1]
	freeze_player_position = player_ref.position
 
func _process(delta):
	if not player_ref:
		return
	var angle = player_ref.look_angle + angle_offset
	var offset = Vector2(cos(angle), sin(angle)).normalized() * angle_distance
	offset += Vector2.UP.rotated(Globals.Rotation) * 4.0
	set_point_position(0, offset)
	
	if player_ref.input != Vector2.ZERO:
		time_to_step -= delta
	if time_to_step <= 0:
		time_to_step = time_per_step
		var step_position = Vector2(cos(player_ref.look_angle), sin(player_ref.look_angle)) * 20.0
		step_position += offset
		step_position += Vector2.UP.rotated((Globals.Rotation + PI)) * 4.0
		set_point_position(1, step_position)
		freeze_step_position = step_position
		freeze_player_position = player_ref.position
	else:
		var position_offset = freeze_player_position - player_ref.position
		set_point_position(1, freeze_step_position + position_offset)
