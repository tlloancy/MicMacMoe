extends Node


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	randomize()
	
#	PlayerData.connect("computer_play", self, "play_computer")
	PlayerData.connect("position_setted", self, "pos_and_action")
	
	reset_data_store()

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
onready var symbol_battlefield: KinematicBody2D = get_node("../../Symbols/Symbol")
onready var game_won = preload("res://src/Objects/tictac/lightsaberCrossVictory.tscn")
onready var game_won2 = preload("res://src/Objects/tictac/lightsaberRoundVictory.tscn")
#positions of rows, columns and diagonals to check is stored in this dictionary
onready var checker_dict = {
	"row_one": [0,1,2],
	"row_two": [3,4,5],  
	"row_three" : [6,7,8],
	"col_one" : [0,3,6],
	"col_two" : [1,4,7],
	"col_three" : [2,5,8],
	"dia_one" : [0,4,8],
	"dia_two" : [2,4,6]    
}

var possible_win_x = []
var possible_win_o = []

## var PlayerData.data_store = [] #stores the current values in each pos
var win = false #to check won or not

func pos_and_action():
	print(PlayerData.pos)
	print(PlayerData.store)
	print("debug")
	#if ! PlayerData.data_store[0]:
	## PlayerData.data_store[0] = "-" ## rien compris
	## Ok ici on revien toujours en -1 qu quilen soit
	########## win = check_win(PlayerData.pos, PlayerData.store)
#	print(win)
#	if !win:
	play_computer()
#	else:
#		print("win")

#function to get the main node
func get_main_node():
	var root = get_tree().get_root()
	return root.get_child(root.get_child_count() - 1)


func reset_data_store():
	possible_win_x = []
	possible_win_o = []
	#this function resets empty values in data store
	win = false
	PlayerData.data_store = []
	for i in range(0,9):
		PlayerData.data_store.append("-")



func get_keys_for_value(value): #this function returns the keys containing that particular value
	var all_keys = checker_dict.keys()
	var keys = []
	for i in range(0, all_keys.size()):
		var values = checker_dict[String(all_keys[i])]
		for j in range(0, values.size()):
			if(values[j] == value):
				keys.append(String(all_keys[i]))
	return keys


func check_win(pos, letter): #checks if won or not after every input
	var tally = 0
	var key = []
	var keys_to_check = get_keys_for_value(pos)

	#check if win occured on all this keys
	for i in range(0,keys_to_check.size()):
		key = keys_to_check[i]
		for j in range(0, checker_dict[key].size()):
			if(PlayerData.data_store[checker_dict[key][j]] == letter):
				tally +=1

		if(tally == 3):
			win = true
			PlayerData.win = true
			break
		elif(tally == 2):
			if(letter == "x"):
				possible_win_x.append(key)
			else:
				possible_win_o.append(key)
			tally = 0
		else:
			tally = 0
	if win:
		won_game(checker_dict[key])
	return win
	## if(win):
	##	pass
#		won_game(checker_dict[key])

func won_game(win_key): #to make a win more interesting.
	var inst = game_won.instance()
	if PlayerData.store == "o":
		inst = game_won2.instance()
	var node = "POS" + String(win_key[1]) #the middle pos of the whole key
	PlayerData.won_position = node
	inst.position = get_main_node().get_node("Symbols/Symbol/" + node).global_position
	var diff = win_key[2] - win_key[0]

	match diff: #equivalent to switch statement
		4:#comes when win key is diagonal
			inst. rotation = deg2rad(-45)
		8:# this too
			inst. rotation = deg2rad(45)
		6:# this is for vertical
			inst. rotation = deg2rad(90)
#
	get_main_node().add_child(inst)


func play_winning_move(pos):
	var played_winning_move = false
	var played_pos = -1
	var key_to_remove = -1    #sometimes once possible wins are stored, that position might be taken by other player and no longer useful

	#all possible win outcomes are stored in possible_win_o array.
	if(possible_win_o.size() > 0): 
		#this means there is a winning possibility
		for i in range(0, possible_win_o.size()):
			#go through all those possibilities
			for j in range(0, checker_dict[possible_win_o[i]].size()):
				#go through all the positions in those possiblities
				if(PlayerData.data_store[checker_dict[possible_win_o[i]][j]] == "-"):
					#if a position is empty
					played_pos = checker_dict[possible_win_o[i]][j] #that should be the position to play
					key_to_remove = i
					#now lets find that node for that particular pos to play
					var node = "POS" + String(played_pos)
					## get_main_node().get_node("Symbols/Symbol/" + node).play_o()
					play_the_game(node, pos)
					played_winning_move = true

				if(played_winning_move):
					return played_winning_move

		if(key_to_remove != -1):
			possible_win_o.remove(key_to_remove)
		else:
			possible_win_o = []

	return played_winning_move  #in case it's false


func block_players_win(pos):
	#same as play_winning_move() but it concers the winning possibilities of x, i.e., possible_win_x array
	var blocked_player = false
	var played_pos = -1
	var key_to_remove = -1    #sometimes once possible wins are stored, that position might be taken by other player and no longer useful

	#all possible win outcomes are stored in possible_win_x array.
	if(possible_win_x.size() > 0): 
		#this means there is a winning possibility
		for i in range(0, possible_win_x.size()):
			#go through all those possibilities
			for j in range(0, checker_dict[possible_win_x[i]].size()):
				#go through all the positions in those possiblities
				if(PlayerData.data_store[checker_dict[possible_win_x[i]][j]] == "-"):
					#if a position is empty
					played_pos = checker_dict[possible_win_x[i]][j] #that should be the position to play
					key_to_remove = i
					#now lets find that node for that particular pos to play
					var node = "POS" + String(played_pos)
					## get_main_node().get_node("Symbols/Symbol/" + node).play_o()
					play_the_game(node, pos)
					blocked_player = true

				if(blocked_player):
					return blocked_player

		if(key_to_remove != -1):
			possible_win_x.remove(key_to_remove)
		else:
			possible_win_x = []

	return blocked_player  #in case it's false

func who_wins_anyway():
	var a = 0
	for i in range(0, PlayerData.data_store.size()):
		if PlayerData.data_store[i] == "o":
			a += 1
	if a == 5:
		PlayerData.win = true
		print ("round wins")
	else:
		PlayerData.win = true
		print ("cross wins")

func check_for_draw():
	var draw = true
	for i in range(0, PlayerData.data_store.size()):
		if(PlayerData.data_store[i] == "-"):
			draw = false  #if one of them is empty, it's not draw
	return draw

func play_the_game(node, pos):
			PlayerData.data_store[pos] = PlayerData.store
			#var place_position = get_main_node()
			#.get_node("Symbols/Symbol/"+node).position
			PlayerData.previous_position = PlayerData.symbol_position
			if PlayerData.data_store[pos] == "x":
				PlayerData.symbol_position = PlayerData.cross_position
			elif PlayerData.data_store[pos] == "o":
				PlayerData.symbol_position = PlayerData.round_position
			sea(false)
#			symbol_battlefield.position -= \
#			get_main_node().get_node("Symbols/Symbol/"+node).position \
#			* 2.5
			PlayerData.node = node
			# le set symbol position prend le node en argumùent
			PlayerData.symbol_position -= get_main_node().get_node("Symbols/Symbol/"+node).position \
			* 2.5 / 4#symbol_battlefield.position

func parcours_symbol(win, pos):
			win = check_win(pos, PlayerData.store)
			if win:
				sea(true)
				print("WIN")
				return true
			var won_by_comp = play_winning_move(pos)     #----->FIRST PRIORITY
			if(won_by_comp):
				sea(true)
				print("CROSS INS")
				return         true        #game ends

			var blocked_players_win = block_players_win(pos)     #------>SECOND PRIORITY
			if(blocked_players_win):
				sea(true)
				print("CIRCLES WINS")
				return     true            #no other move needed

			return false                  #it's like stalemate. Nothing to do
func play_computer():
	if win : return
#	var won_by_comp = play_winning_move()     #----->FIRST PRIORITY
#	if(won_by_comp):
#		print("CROSS INS")
#		return                 #game ends
#
#	var blocked_players_win = block_players_win()     #------>SECOND PRIORITY
#	if(blocked_players_win):
#		print("CIRCLES WINS")
#		return                 #no other move needed
##
##
#	var draw = check_for_draw()        #------->THIRD PRIORITY
#	if(draw):
#		print("DRAW")
#		return                  #it's like stalemate. Nothing to do

	#if nothing, take a random pos and play
	if check_for_draw():
		print("DRAW")
		return
	var can_take_pos = false #boolean to check if that particular position can be taken
	while(!can_take_pos):
		#as long as that position canot be taken we need another random pos
		var pos = randi()%9  #random numbers from 0 - 8
		if(PlayerData.data_store[pos] == "-"):
			can_take_pos = true
			## var node = "POS" + String(pos)
			var node = "POS" + String(pos)
			print(node)
			## debug
			if parcours_symbol(win, pos):
				win = check_win(pos, PlayerData.store)
				if win: return
			play_the_game(node, pos)
			if check_for_draw():
				who_wins_anyway()
				print("DRAWW")
			### PlayerData.symbol_scale = Vector2(1.5, 1.25)
			## get_main_node().get_node("Symbols/Symbol/"+node).play_o()
			## print(get_main_node().get_node("Symbols/Symbol/"+node).position)
func sea(end) -> void:
	for i in range(0, PlayerData.data_store.size()):
				##print(PlayerData.data_store[i])
				if (i + 1) % 3 == 0:
					print (PlayerData.data_store[i - 2] +
					PlayerData.data_store[i - 1] +
					PlayerData.data_store[i]
					)
	#if end:
	#	reset_data_store()
		



#func _process(delta):
#	if(Input.is_key_pressed(KEY_ENTER)): #to restart game
#		possible_win_o = []
#		possible_win_x = []
#		reset_data_store()
#		get_tree().reload_current_scene()
#
#	if(Input.is_action_just_pressed("ui_select")):  #for testing, press space
#		play_computer()

