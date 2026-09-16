extends CanvasLayer

@onready var CamelClue1 = $UI/CamelClue1;
@onready var CamelClue2 = $UI/CamelClue2;
@onready var CamelClue3 = $UI/CamelClue3;
@onready var CamelClue4 = $UI/CamelClue4;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CamelClue1.hide()
	CamelClue2.hide()
	CamelClue3.hide()
	CamelClue4.hide()
	pass
