extends Node

signal deaths_updated
signal player_died
signal score_updated
signal we_have_win
signal we_have_draw
#signal computer_play
signal position_setted
signal symbol_moved(symbol_node_pos)
#signal response_setted

var score: = 0 setget set_score
var deaths: = 0 setget set_deaths
#var played_tictac: = 0 setget set_played_tictac

func reset() -> void:
	score = 0
	deaths = 0

func set_score(value: int) -> void:
	score = value
	emit_signal("score_updated")
	
func set_deaths(value: int) -> void:
	deaths = value
	emit_signal("player_died")


## =============
#func set_played_tictac(value: int) -> void:
#	played_tictac = value
#	emit_signal("computer_play")


var win: = false setget set_win
var pos = -1 setget set_pos
var store: = "" setget set_store
var node = "POS-1" setget set_node
var data_store = [] setget set_data_store
var won_position: = "" setget set_won_position
var round_position: = Vector2(0, 0) setget set_round_position
var cross_position: = Vector2(0, 0) setget set_cross_position
var symbol_position: = Vector2(1241, 270) setget set_symbol_position
var previous_position: = Vector2(0, 0) setget set_previous_position
### var symbol_scale = Vector2(0.3, 0.25)

func set_data_store(value: Array) -> void:
	data_store = value

func set_win(value: bool) -> void:
	win = value
	emit_signal("we_have_win")

func set_pos(value: int) -> void:
	pos = value
	
func set_won_position(value):
	won_position = value


func set_store(value: String) -> void:
	store = value
## popur la croix et le cercle . L acroix detect l entree du joueur
## elle donne sa position ce que declenle le signal position setted
func set_cross_position(value: Vector2) -> void:
	cross_position = value
	emit_signal("position_setted")
		
func set_round_position(value: Vector2) -> void:
	round_position = value
	emit_signal("position_setted")
# puis dans user interface; la reponse de l oridnateur declenchee
# par le signal ci dessus est la nouvelle position du symbole
# il va se positionner la ou la croixx ou le rond doivent etre

# il va de fait envoyer quelle partie de lui "node" est situee la croix
# pour  qu elle le suivce 
func set_symbol_position(value: Vector2) -> void:
	symbol_position = value
	emit_signal("symbol_moved", node)

func set_previous_position(value: Vector2) -> void:
	previous_position = value
	
func set_node(value: String) -> void:
	node = value
#	emit_signal("response_setted")
## =============


## 2048 ##
var winmill = null setget set_winmill
var trapped = 0 setget set_trapped
var victory = 0 setget set_victory
var expire = 0 setget set_victory
var map = [] setget set_map
var direction_possible = [] setget set_direction_possible
var direction = [] setget set_direction
var trapped_for_good = 0 setget set_trapped_for_good
signal myturnasatile
var whowhere = [] setget set_whowhere
var fancy_map = [] setget set_fancy_map

func set_whowhere(value):
	whowhere = value
	emit_signal("myturnasatile", whowhere)
func set_winmill(value):
	winmill = value
	emit_signal("we_have_win")
	pass
func set_trapped(value):
	trapped = value
	#emit_signal("we_have_win")
	pass
func set_trapped_for_good(value):
	trapped_for_good = value
	emit_signal("we_have_draw")
func set_victory(value):
	victory = value
	pass
func set_expire(value):
	expire = value
	pass
func set_map(value: Array) -> void:
	map = value
	pass
func set_direction_possible(value):
	direction_possible = value
	pass
func set_direction(value):
	direction = value
	pass
func set_fancy_map(value: Array) -> void:
	fancy_map = value
## ##

## chess ##

## ##
