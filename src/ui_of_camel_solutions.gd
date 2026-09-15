extends CanvasLayer

@onready var CamelClue1 = $UI/CamelClue1;
@onready var CamelClue2 = $UI/CamelClue2;
@onready var CamelClue3 = $UI/CamelClue3;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CamelClue1.hide()
	CamelClue2.hide()
	CamelClue3.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
