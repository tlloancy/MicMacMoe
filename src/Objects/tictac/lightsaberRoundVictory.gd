extends Area2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if PlayerData.win:
		var t = delta * 7
		var x = get_main_node().get_node("Symbols/Symbol/"+PlayerData.won_position).global_position
		position = position.linear_interpolate(x, t)
#	pass

func get_main_node():
	var root = get_tree().get_root()
	return root.get_child(root.get_child_count() - 1)
