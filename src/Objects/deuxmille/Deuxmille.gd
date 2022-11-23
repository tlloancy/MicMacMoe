extends KinematicBody2D
var WIN_VALUE = 2048
var winmill = false
var trapped = 0
#var iii
#var iinst
#var font

export var two_piece: PackedScene
export var four_piece: PackedScene

func board_verify():
	var dir
	var id

	dir = 0;
	PlayerData.trapped = 1;
	PlayerData.direction_possible.resize(4)
	while (dir < 4):
		PlayerData.direction_possible[dir] = 0
		id = 0
		while (id < 16):
			if (PlayerData.map[id] == WIN_VALUE):
				winmill = true
				PlayerData.victory = 1
			if (board_tile_may_move(id, PlayerData.direction[dir])):
				PlayerData.direction_possible[dir] = 1
			id += 1
		if PlayerData.direction_possible[dir]:
			PlayerData.trapped = 0
		dir += 1
	#board->color = board->trapped ? 4 : 5 + board->victory;

func board_spawn():

	var destination;
	var space;
	var i;

	i = 0;
	space = 0;
	while (i < 16):
		space += 1 if PlayerData.map[i] == 0 else 0;
		i +=1
	if (space == 0):
		return ;
	destination = randi() % space;
	i = 0;
	while (i <= destination && i < 16):
		if (PlayerData.map[i] > 0):
			destination +=1;
		if (i == destination && PlayerData.map[i] == 0):
			PlayerData.map[i] = 4 if (randi() % 10 < 1) else 2;
			the_graphical_part(21, i, PlayerData.map)
		i+=1;

func	board_fill_arrays():
	PlayerData.direction.resize(4)
	PlayerData.direction[0] = 1;
	PlayerData.direction[1] = -1;
	PlayerData.direction[2] = 4;
	PlayerData.direction[3] = -4;
	#direction_key[0] = 259;
	#direction_key[1] = 260;
	#direction_key[2] = 258;
	#direction_key[3] = 261;

func grid_reset_men():
	var i = 0;
	PlayerData.fancy_map.resize(16)
	PlayerData.map.resize(16)
	while (i < 16):
		PlayerData.fancy_map[i] = 0
		PlayerData.map[i] = 0
		i += 1
	#PlayerData.winmill = false;
	PlayerData.score = 0;
	#PlayerData.trapped = 0;
	PlayerData.victory = 0;
	PlayerData.expire = 0;
	board_fill_arrays();
	board_spawn();
	board_spawn();
	board_verify();

func _ready() -> void:
	randomize()
	grid_reset_men()

#func get_direction() -> Vector2:
#	return Vector2(
#		PlayerData.symbol_position.x - PlayerData.previous_position.x,
#		PlayerData.symbol_position.y - PlayerData.previous_position.y
#	)
#



func	refresh_lives_level_and_score(winmill, trapped):
	#mvaddstr(0, 1, "Score : ");
	if (PlayerData.trapped):
		trapped = true
		#mvaddstr(0, 15, "You lose! ESC to quit");
		return 0
	elif (PlayerData.victory):
		PlayerData.winmill = true
		#mvaddstr(0, 15, "You win! ESC to quit");
		return 0
	return 1

func get_main_node():
	var root = get_tree().get_root()
	return root.get_child(root.get_child_count() - 1)

func dioudz():
	#var labelone = get_node("label1")
	#var font = labelone.get_font("")

	var iii = 0;
	while (iii < 16):
		var onode = "OPOS" + String(iii)
		#var iinstwo = get_node("Label"+ String(iii))
		#iinstwo.text = ""
		var gettile = ""
		var iinst = get_main_node().get_node("Symbols/Symbol/" + onode)
		for child in iinst.get_children():
			child.queue_free()
		if (iii % 4 == 0 && PlayerData.map[iii] > 0): # 1ere colonne etc
			gettile = load("res://src/Objects/deuxmille/tile"+String(PlayerData.map[iii])+".tscn")
			####gettile = get_node("tile" + String(PlayerData.map[iii]))
			var onetile = gettile.instance()
			onetile.position = iinst.position / 10
			onetile.scale.x = 2.5
			onetile.scale.y = 2.5
			iinst.add_child(onetile)
			####gettile.position = iinst.position
			#iinstwo.text = String(PlayerData.map[iii])
	#		draw_string(font, Vector2(600,600), "za");
		elif (iii % 4 == 1 && PlayerData.map[iii] > 0):
			gettile = load("res://src/Objects/deuxmille/tile"+String(PlayerData.map[iii])+".tscn")
			var onetile = gettile.instance()
			onetile.position = iinst.position / 10
			onetile.scale.x = 2.5
			onetile.scale.y = 2.5
			iinst.add_child(onetile)
			#iinstwo.text =  String(PlayerData.map[iii])
	#		draw_string(font, iinst.global_position, String(PlayerData.map[iii]));
		elif (iii % 4 == 2 && PlayerData.map[iii] > 0):
			gettile = load("res://src/Objects/deuxmille/tile"+String(PlayerData.map[iii])+".tscn")
			var onetile = gettile.instance()
			onetile.position = iinst.position / 10
			onetile.scale.x = 2.5
			onetile.scale.y = 2.5
			iinst.add_child(onetile)
			#iinstwo.text = String(PlayerData.map[iii])
	#		draw_string(font, iinst.global_position, String(PlayerData.map[iii]));
		elif (iii % 4 == 3 && PlayerData.map[iii] > 0):
			gettile = load("res://src/Objects/deuxmille/tile"+String(PlayerData.map[iii])+".tscn")
			var onetile = gettile.instance()
			onetile.position = iinst.position / 10
			onetile.scale.x = 2.5
			onetile.scale.y = 2.5
			iinst.add_child(onetile)
			#iinstwo.text = String(PlayerData.map[iii])
	#		draw_string(font, iinst.global_position, String(PlayerData.map[iii]));
		iii += 1
			

func	ft_numbs():
		#call_deferred("_draw")
		##_draw()
		##update()
		dioudz()

func		ft_board_appearance(winmill, trapped):
	var	i;

	i = 0;
	## ft_numbs();
	return refresh_lives_level_and_score(winmill, trapped);

func	board_tile_may_move(id, dir):
	var	dest;

	if (PlayerData.map[id] == 0):
		return (0);
	dest = id + dir;
	if (dest < 0):
		return (0);
	if (dest > 15):
		return (0);
	if (dir == -1 && (dest % 4) == 3):
		return (0);
	if (dir == 1 && (dest % 4) == 0):
		return (0);
	if (PlayerData.map[dest] == 0):
		return (1);
	if (PlayerData.map[dest] == PlayerData.map[id]):
		return (1);
	return (0);

func	board_move_tile(id, dir):
	var	dest;
	var	origin;

	dest = id + dir;
	origin = PlayerData.map[id];
	while (board_tile_may_move(id, dir) && origin == PlayerData.map[id]):
		the_graphical_part(dest, id, PlayerData.fancy_map)
		PlayerData.map[dest] += PlayerData.map[id];
		PlayerData.map[id] = 0;
		id = dest;
		dest = id + dir;
	if (origin != PlayerData.map[id]):
		PlayerData.score += PlayerData.map[id];

func		board_move(dir):
	var	start;
	var	finish;
	var	id;

	start = 15 if (dir > 0) else 0;
	finish = -1 if (dir > 0) else 16;
	id = start;
	while (id != finish):
		if (PlayerData.map[id] > 0):
			board_move_tile(id, dir);
		id += 1 if (id < finish) else -1;
	board_spawn();
	board_verify();



func getinput():
	if (Input.is_action_just_released("move_right") && PlayerData.direction_possible[0]):
		board_move(PlayerData.direction[0]);
	elif (Input.is_action_just_released("move_left") && PlayerData.direction_possible[1]):
		board_move(PlayerData.direction[1]);
	elif (Input.is_action_just_pressed("move_down") && PlayerData.direction_possible[2]):
		board_move(PlayerData.direction[2]);
	elif (Input.is_action_just_released("jump") && PlayerData.direction_possible[3]):
		board_move(PlayerData.direction[3]);
	#else if (c == 27)
	#	return (0);
	return (1);

func	display_board(winmill, trapped):
	return ft_board_appearance(winmill, trapped)

func _physics_process(delta: float) -> void:
	getinput()
	if (display_board(winmill, trapped) == 0):
		if trapped == 0 && winmill:
			PlayerData.winmill = true
		else:
			PlayerData.trapped_for_good = 1
			pass
	#update()
var x_start := - 570 # plus c grand plus c a droite
var y_start := 530 # plus c grand plus c vers le bas
var offset := 384
func grid_to_pixel(grid_position: Vector2):
	var new_x = x_start + offset * grid_position.x # column
	var new_y = y_start - offset * grid_position.y # row
	return Vector2(new_x, new_y)

func pixel_to_grid(pixel_position: Vector2):
	var new_x = round((pixel_position.x - x_start) / offset)
	var new_y = round((pixel_position.y - y_start) / -offset)
	return Vector2(new_x, new_y)


func the_graphical_part(which_one, index, data):
	if which_one == 21:
		var temp = four_piece.instance() if data[index] == 4 else two_piece.instance()
		##rescale_pieces(temp)
		add_child(temp)
		PlayerData.fancy_map[index] = temp
		temp.position = grid_to_pixel(Vector2(index % 4, index / 4))
	else:
		var this_piece = data[index]
		this_piece.move(grid_to_pixel(Vector2(which_one % 4, which_one / 4)))
		# au lieu de chercher dans les noeuds comme un neuneu
		if PlayerData.map[which_one] == PlayerData.map[index]:
			remove_and_clear(which_one)
			this_piece.remove()
			var tmp = this_piece.next_value
			var new_piece = tmp.instance()
			##rescale_pieces(new_piece)
			add_child(new_piece)
			PlayerData.fancy_map[which_one] = new_piece
			new_piece.position = grid_to_pixel(Vector2(which_one % 4, which_one / 4))
		else:
			PlayerData.fancy_map[which_one] = this_piece	
		PlayerData.fancy_map[index] = null
			
func remove_and_clear(which_one):
	PlayerData.fancy_map[which_one].remove()
	PlayerData.fancy_map[which_one] = null

##func rescale_pieces(temp):
##	temp.scale.x = 2.5
##	temp.scale.y = 2.5
