extends TouchScreenButton

var ev

func simulate_key() -> void:
# Set as move_left, pressed.
	ev.action = "move_right"
	ev.pressed = true
# Feedback.
	#Input.parse_input_event(ev)
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
func unsimulate_key():
	ev.pressed = false

func _on_button_released() -> void:
	unsimulate_key()
	pass
	
func _on_button_pressed() -> void:
	print("ok")
	simulate_key()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ev = InputEventAction.new()
	ev.pressed = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
#	pass
	if Input.get_accelerometer().x > 0.5:
		simulate_key()
	else:
		unsimulate_key()
	Input.parse_input_event(ev)
