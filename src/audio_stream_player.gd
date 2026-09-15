extends AudioStreamPlayer

@onready var music_list: Array[AudioStream] = [
	preload("res://Sounds/Theme_Music/music 1_edited.mp3"),
	preload("res://Sounds/Theme_Music/Music 2_edited.mp3"),
	preload("res://Sounds/Theme_Music/solving puzzel 1_editedmp3.mp3"),
	preload("res://Sounds/Theme_Music/solving puzzle 2_Edited.mp3")
]
var current_index: int = 0
func _ready() -> void:
	finished.connect(_on_finished)
	play_current()

func play_current() -> void:
	if music_list.is_empty():
		return
	stream = music_list[current_index]
	play()

func _on_finished() -> void:
	current_index += 1
	if current_index >= music_list.size():
		current_index = 0
	play_current()
