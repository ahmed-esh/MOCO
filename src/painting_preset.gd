extends Control

var FirstCamelDone = false;
var SecondCamelDone = false;
var thridaCamelDone = false;




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (FirstCamelDone and SecondCamelDone and thridaCamelDone):
		print("you are done")
	pass


func SmallCamel1(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			Camel1_clicked()
			$ThePainintg/SmallCamel1.hide();



func SmallCamel2(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			Camel2_clicked()
			$ThePainintg/SmallCamel2.hide();



func SmallCamel3(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			Camel3_clicked()
			$ThePainintg/SmallCamel3.hide();
	pass # Replace with function body.


func Camel1_clicked():
	$CamelClue1.show()
	FirstCamelDone = true;
	pass
	
func Camel2_clicked():
	$CamelClue2.show()
	SecondCamelDone = true;

func Camel3_clicked():
	$CamelClue3.show()
	thridaCamelDone = true;
	
