extends HSlider


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_HSlider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1, lerp(AudioServer.get_bus_volume_db(1), 
	value, 0.5))
	if value == -24:
		AudioServer.set_bus_mute(1, true)
	else:
		AudioServer.set_bus_mute(1, false)



func _on_HSlider2_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(2, lerp(AudioServer.get_bus_volume_db(2), 
	value, 0.5))
	if value == -24:
		AudioServer.set_bus_mute(2, true)
	else:
		AudioServer.set_bus_mute(2, false)
