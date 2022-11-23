extends Node
onready var Croos = preload ("res://src/Objects/tictac/Cross.tscn")
onready var Round = preload ("res://src/Objects/tictac/Round.tscn")
var timeToPlayTheGame = 3 - 2
var timer = 0
onready var ul = get_main_node().get_node("ul")
onready var ur = get_main_node().get_node("ur")
onready var dl = get_main_node().get_node("dl")
onready var dr = get_main_node().get_node("dr")
onready var rounds = get_main_node().get_node("Rounds")
onready var crosses = get_main_node().get_node("Crosses")
#onready var c = Croos.instance()
#onready var r = Round.instance()
onready var posul = ul.position
onready var posur = ur.position
onready var posdl = dl.position
onready var posdr = dr.position
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	pass # Replace with function body.
func put_instance(pos, cross, crosses, rounds):
	
	if cross == true:
		var c = Croos.instance()
		c.position = pos
		c.scale = Vector2(0.3, 0.25)
		crosses.add_child(c)
	else:
		var r = Round.instance()
		r.position = pos
		r.scale = Vector2(0.3, 0.25)
		rounds.add_child(r)
func determine_cros_position(pos):
	var headortail = randi() % 4	
	if headortail < 2:
		if headortail < 1:
			pos = posul
		else:
			pos = posur
		# On the left
		#pos.x -= rand_range(50.0, 200.0)
	else:
		if headortail > 2:
			pos = posdr
		else:
			pos = posdl
		# On the right
		#pos.x += rand_range(50.0, 200.0)
	return pos	
func get_main_node():
	var root = get_tree().get_root()
	return root.get_child(root.get_child_count() - 1)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += delta
	if timer >= timeToPlayTheGame:
		genrate()	
		timer = 0 
func genrate():
	var pos := Vector2(0, 0)
	var cross = true	
	randomize()
	if randf() < 0.5:
			pass
	else:
			cross = false
	
	pos = determine_cros_position(pos)
	put_instance(pos, cross, crosses, rounds)
