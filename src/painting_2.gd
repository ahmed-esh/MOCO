extends Control

var FirstCamelDone = false
var SecondCamelDone = false


@onready var smallcamel1pos = $ThePainintg/SmallCamel1.position
@onready var smallcamel2pos = $ThePainintg/SmallCamel2.position

var text_options: Array[String] = [
	"XXXXXXXXXXXXXXXX...",
	"XXXXXXXXXXXXXXX?",
	"SXXXXXXXXXXXXXXX.",
	"XXXXXXXXXXXXXXXXXXXXX.",
	"TXXXXXXXXXXXXXXXXXXX."
]
func _process(delta: float) -> void:
	if (FirstCamelDone and SecondCamelDone):
		print("you are done")
		set_process(false) 

func SmallCamel1(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if not FirstCamelDone: 
			FirstCamelDone = true
			$ThePainintg/SmallCamel1.hide() 
			animate_clue_discovery1(smallcamel1pos, UiOfCamelSolutions.CamelClue3.position)

func SmallCamel2(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if not SecondCamelDone:
			SecondCamelDone = true
			$ThePainintg/SmallCamel2.hide()
			animate_clue_discovery2(smallcamel2pos, UiOfCamelSolutions.CamelClue4.position)


# --- THE ANIMATION ENGINE ---

func animate_clue_discovery1(start_pos: Vector2, target_pos: Vector2):
	UiOfCamelSolutions.CamelClue3.position = start_pos
	UiOfCamelSolutions.CamelClue3.scale = Vector2.ZERO
	UiOfCamelSolutions.CamelClue3.modulate.a = 0.0
	UiOfCamelSolutions.CamelClue3.show()
	
	var tween = create_tween().set_parallel(true)
	
	tween.tween_property(UiOfCamelSolutions.CamelClue3, "modulate:a", 1.0, 0.3).set_trans(Tween.TRANS_QUAD)
	
	tween.tween_property(UiOfCamelSolutions.CamelClue3, "scale", Vector2(0.2, 0.2), 0.4).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(UiOfCamelSolutions.CamelClue3, "position", target_pos, 0.7).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)


func animate_clue_discovery2(start_pos: Vector2, target_pos: Vector2):
	UiOfCamelSolutions.CamelClue4.position = start_pos
	UiOfCamelSolutions.CamelClue4.scale = Vector2.ZERO
	UiOfCamelSolutions.CamelClue4.modulate.a = 0.0
	UiOfCamelSolutions.CamelClue4.show()
	
	var tween = create_tween().set_parallel(true)
	
	tween.tween_property(UiOfCamelSolutions.CamelClue4, "modulate:a", 1.0, 0.3).set_trans(Tween.TRANS_QUAD)
	
	tween.tween_property(UiOfCamelSolutions.CamelClue4, "scale", Vector2(0.2, 0.2), 0.4).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(UiOfCamelSolutions.CamelClue4, "position", target_pos, 0.7).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)



func _ready() -> void:
	start_text_cycle()

func start_text_cycle() -> void:
	var initial_delay = randf_range(10.0, 15.0)
	await get_tree().create_timer(initial_delay).timeout
	
	await spawn_random_text()
	await get_tree().create_timer(20.0).timeout
	await spawn_random_text()
	await get_tree().create_timer(5.0).timeout
	
	clear_all_text()
	start_text_cycle()

func spawn_random_text() -> void:
	var label = $RichTextLabel
	
	label.bbcode_enabled = true
	label.text = text_options.pick_random()
	label.fit_content = true
	label.visible_characters = 0
	label.add_to_group("dynamic_text")
	add_child(label)
	
	# --- ANIMATION & SOUND LOGIC ---
	var total_chars = label.get_total_character_count()
	
	var animation_duration = total_chars * 0.05 
	
	Globals.playmumble.play()
	
	var tween = create_tween()
	tween.tween_property(label, "visible_characters", total_chars, animation_duration)
	
	await tween.finished

func clear_all_text() -> void:
	Globals.playmumble.stop()
	
	var active_texts = get_tree().get_nodes_in_group("dynamic_text")
	for node in active_texts:
		node.queue_free()
