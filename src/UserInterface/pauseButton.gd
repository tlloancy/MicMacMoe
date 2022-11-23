extends TouchScreenButton
var ev
func simulate_key() -> void:
############	var ev = InputEventAction.new()
# Set as move_left, pressed.
	ev.action = "pause"
	ev.pressed = true
	Input.parse_input_event(ev)

func unsimulate_key():
	ev.pressed = false
	ev.action = "pause"
# Feedback.
	Input.parse_input_event(ev)
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
func _on_button_released() -> void:
	simulate_key()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ev = InputEventAction.new()
	ev.pressed = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
##func _process(delta: float) -> void:
	##Input.parse_input_event(ev)
#	pass


func _on_button_pressed() -> void:
	unsimulate_key()
	pass # Replace with function body.
