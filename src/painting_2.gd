extends Control

var FirstCamelDone = false
var SecondCamelDone = false


@onready var smallcamel1pos = $ThePainintg/SmallCamel1.position
@onready var smallcamel2pos = $ThePainintg/SmallCamel2.position

func _process(delta: float) -> void:
	if (FirstCamelDone and SecondCamelDone):
		print("you are done")
		set_process(false) 

func SmallCamel1(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if not FirstCamelDone: 
			FirstCamelDone = true
			$ThePainintg/SmallCamel1.hide() 
			animate_clue_discovery1(smallcamel1pos, UiOfCamelSolutions.CamelClue1.position)

func SmallCamel2(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if not SecondCamelDone:
			SecondCamelDone = true
			$ThePainintg/SmallCamel2.hide()
			animate_clue_discovery2(smallcamel2pos, UiOfCamelSolutions.CamelClue2.position)


# --- THE ANIMATION ENGINE ---

func animate_clue_discovery1(start_pos: Vector2, target_pos: Vector2):
	UiOfCamelSolutions.CamelClue1.position = start_pos
	UiOfCamelSolutions.CamelClue1.scale = Vector2.ZERO
	UiOfCamelSolutions.CamelClue1.modulate.a = 0.0
	UiOfCamelSolutions.CamelClue1.show()
	
	var tween = create_tween().set_parallel(true)
	
	tween.tween_property(UiOfCamelSolutions.CamelClue1, "modulate:a", 1.0, 0.3).set_trans(Tween.TRANS_QUAD)
	
	tween.tween_property(UiOfCamelSolutions.CamelClue1, "scale", Vector2(1.0, 1.0), 0.4).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(UiOfCamelSolutions.CamelClue1, "position", target_pos, 0.7).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)


func animate_clue_discovery2(start_pos: Vector2, target_pos: Vector2):
	UiOfCamelSolutions.CamelClue2.position = start_pos
	UiOfCamelSolutions.CamelClue2.scale = Vector2.ZERO
	UiOfCamelSolutions.CamelClue2.modulate.a = 0.0
	UiOfCamelSolutions.CamelClue2.show()
	
	var tween = create_tween().set_parallel(true)
	
	tween.tween_property(UiOfCamelSolutions.CamelClue2, "modulate:a", 1.0, 0.3).set_trans(Tween.TRANS_QUAD)
	
	tween.tween_property(UiOfCamelSolutions.CamelClue2, "scale", Vector2(1.0, 1.0), 0.4).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(UiOfCamelSolutions.CamelClue2, "position", target_pos, 0.7).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
