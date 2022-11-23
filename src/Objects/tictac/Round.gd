extends Area2D


#onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")
onready var symbol_battlefield: KinematicBody2D = get_node("../../Symbols/Symbol")#get_node("../../Symbols/tictactoegrid__clipart211931")

export var score: = 100

var hooked = false
var good_node
var onetimeonly = false

var symbol_arrived = false

##const FLOOR_NORMAL: = Vector2.UP

##export var speed: = Vector2(300.0, 1000.0)
###export var gravity: = 4000.0

##var _velocity: = Vector2.ZERO
var LIIIfeTIME = 1000000000
var timer = 0

func _ready() -> void:
		randomize()
		var wherex = randi() % 20
		var wherey = randi() % 10 + 4
		PlayerData.connect("symbol_moved", self, "adjust_position")
		if scale == Vector2(0.3, 0.25):
			LIIIfeTIME = 4
			position = Vector2(wherex * 100, wherey * 100)

func _physics_process(delta: float) -> void:
	timer += delta
	if timer >= LIIIfeTIME:
		queue_free()
	if symbol_arrived:
		var t = delta * 7 ## evidemment c pas au pif en lien avec ecc=helle / 4
		var x = good_node.position * 2.5 / 4 + PlayerData.symbol_position
		position = position.linear_interpolate(x, t)
		if !onetimeonly:
			onetimeonly = !onetimeonly
			
func get_main_node():
	var root = get_tree().get_root()
	return root.get_child(root.get_child_count() - 1)

func adjust_position(node_position: String) -> void:
	if hooked:
		symbol_arrived = true
		if !onetimeonly:
			good_node = get_main_node().get_node("Symbols/Symbol/"+node_position)

func _on_Round_body_entered(body: Node) -> void:
	if !hooked:
		picked(position.x, position.y)
	
func picked(xcoin, ycoin) -> void:
	PlayerData.score += score
	hooked = true
	print(xcoin)
	print(symbol_battlefield.position.x)
	#anim_player.play("fade_out")
	play_o()
	########### PlayerData.played_tictac += 1
	## reponse dans la fonction play_computer du fichier userinterface
	## symbol_battlefield.position.x = xcoin
	## symbol_battlefield.position.y = ycoin
	#symbol_battlefield.position = symbol_battlefield.position.move_toward(Vector2(xcoin, ycoin), 100)

func play_o():
		LIIIfeTIME = 10000000000
##	if(!selected and !PlayerData.win):
#		$x_o.set_texture(x)
#		$mouse_over.hide()
##		selected = true
###		PlayerData.pos = pos
		PlayerData.store = "o"
		PlayerData.round_position = position
		#PlayerData.data_store[pos] = "x"
		#PlayerData.check_win(pos, "x")
