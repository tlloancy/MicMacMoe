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
#export var gravity: = 4000.0

##var _velocity: = Vector2.ZERO
var LiiiFETime = 10000000000000
var timer = 0

func _ready() -> void:
		randomize()
		var wherex = randi() % 20
		var wherey = randi() % 10 + 3
		PlayerData.connect("symbol_moved", self, "adjust_position")
		if scale == Vector2(0.3, 0.25):
			LiiiFETime = 3
			position = Vector2(wherex * 100, wherey * 100)#_velocity.x = -speed.x
		
func _physics_process(delta: float) -> void:
	timer += delta
	if timer >= LiiiFETime:
		queue_free()
	# avec un bon speed le sybole est deja arrivé mais ce qui est sur c'est
	# qu avec le signal adjust position recu il est deja en cours d eroute
	if symbol_arrived:
		## on effectue un mouvement paralle et dans la meme direction
		# et a la meme vitesse
		var t = delta * 7
		var x = good_node.position * 2.5 / 4 + PlayerData.symbol_position
		position = position.linear_interpolate(x, t)
		if !onetimeonly: ## Cette loop est ultrarapide
			onetimeonly = !onetimeonly ## je pense qu il faut attendre puisqqe

#function to get the main node
func get_main_node():
	var root = get_tree().get_root()
	return root.get_child(root.get_child_count() - 1)

func adjust_position(node_position: String) -> void:
	# Bon en gros ca voulait dire que si cette croix avait ete touchee
	# OK elle peut repondre au signal qui lui dit de suivre le symbole
	## le tien comme un cerf Volant ? Kyle hasegawa
	if hooked:
		symbol_arrived = true #
	# c est subjectif mais je ne veux pas que les objets s attirent
	# d abord le symbole arrive en position apores la croix le suit partout
		#position = PlayerData.symbol_position
		if !onetimeonly: # ainsi toutes les stars ne vont pas aau meme endroit
			good_node = get_main_node().get_node("Symbols/Symbol/"+node_position)
#		position = good_node.position
#		print(good_node)

func _on_Cross_body_entered(body: Node) -> void:
	#monitoring = false
	#monitorable = false
	if ! hooked:
		picked(position.x, position.y)
	
func picked(xcoin, ycoin) -> void:
	PlayerData.score += score
	hooked = true
	print(xcoin)
	print(symbol_battlefield.position.x)
	#anim_player.play("fade_out")
	play_x()
	########### PlayerData.played_tictac += 1
	## reponse dans la fonction play_computer du fichier userinterface
	## symbol_battlefield.position.x = xcoin
	## symbol_battlefield.position.y = ycoin
	#symbol_battlefield.position = symbol_battlefield.position.move_toward(Vector2(xcoin, ycoin), 100)

func play_x():
		LiiiFETime = 10000000000
##	if(!selected and !PlayerData.win):
#		$x_o.set_texture(x)
#		$mouse_over.hide()
##		selected = true
###		PlayerData.pos = pos
		PlayerData.store = "x"
		PlayerData.cross_position = position
		#PlayerData.data_store[pos] = "x"
		#PlayerData.check_win(pos, "x")
