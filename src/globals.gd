extends Node

@export var Rotation : float = 0.0
@onready var playmumble = $MumbleSFX

@onready var songs: Array[AudioStream] = [
	preload("res://Sounds/Theme_Music/music 1.wav"),
	preload("res://Sounds/Theme_Music/Music 2.wav"),
	preload("res://Sounds/Theme_Music/solving puzzel 1.wav"),
	preload("res://Sounds/Theme_Music/solving puzzle 2.wav"),
]
