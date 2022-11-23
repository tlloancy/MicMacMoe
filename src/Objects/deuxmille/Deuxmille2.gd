extends KinematicBody2D
var WIN_VALUE = 2048
var winmill = false
var trapped = 0
#var iii
#var iinst
#var font

export var twopiece: PackedScene
export var fourpiece: PackedScene

func board_verify():
	var dir
	var id

	dir = 0;
	EnemyData.trapped = 1;
	EnemyData.direction_possible.resize(4)
	while (dir < 4):
		EnemyData.direction_possible[dir] = 0
		id = 0
		while (id < 16):
			if (EnemyData.map[id] == WIN_VALUE):
				winmill = true
				EnemyData.victory = 1
			if (board_tile_may_move(id, EnemyData.direction[dir])):
				EnemyData.direction_possible[dir] = 1
			id += 1
		if EnemyData.direction_possible[dir]:
			EnemyData.trapped = 0
		dir += 1
	#board->color = board->trapped ? 4 : 5 + board->victory;

func board_spawn():

	var destination;
	var space;
	var i;

	i = 0;
	space = 0;
	while (i < 16):
		space += 1 if EnemyData.map[i] == 0 else 0;
		i +=1
	if (space == 0):
		return ;
	destination = randi() % space;
	i = 0;
	while (i <= destination && i < 16):
		if (EnemyData.map[i] > 0):
			destination +=1;
		if (i == destination && EnemyData.map[i] == 0):
			EnemyData.map[i] = 4 if (randi() % 10 < 1) else 2;
			the_graphical_part(21, i, EnemyData.map)
		i+=1;

func	board_fill_arrays():
	EnemyData.direction.resize(4)
	EnemyData.direction[0] = 1;
	EnemyData.direction[1] = -1;
	EnemyData.direction[2] = 4;
	EnemyData.direction[3] = -4;
	#direction_key[0] = 259;
	#direction_key[1] = 260;
	#direction_key[2] = 258;
	#direction_key[3] = 261;

func grid_reset_men():
	var i = 0;
	EnemyData.fancymap.resize(16)
	EnemyData.map.resize(16)
	while (i < 16):
		EnemyData.fancymap[i] = 0
		EnemyData.map[i] = 0
		i += 1
	#EnemyData.winmill = false;
	EnemyData.score = 0;
	#EnemyData.trapped = 0;
	EnemyData.victory = 0;
	EnemyData.expire = 0;
	board_fill_arrays();
	board_spawn();
	board_spawn();
	board_verify();

func _ready() -> void:
	randomize()
	grid_reset_men()

	EnemyData.connect("ia_played", self, "decision")
#func get_direction() -> Vector2:
#	return Vector2(
#		EnemyData.symbol_position.x - EnemyData.previous_position.x,
#		EnemyData.symbol_position.y - EnemyData.previous_position.y
#	)
#



func	refresh_lives_level_and_score(winmill, trapped):
	#mvaddstr(0, 1, "Score : ");
	if (EnemyData.trapped):
		trapped = true
		#mvaddstr(0, 15, "You lose! ESC to quit");
		return 0
	elif (EnemyData.victory):
		EnemyData.winmill = true
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
		if (iii % 4 == 0 && EnemyData.map[iii] > 0): # 1ere colonne etc
			gettile = load("res://src/Objects/deuxmille/tile"+String(EnemyData.map[iii])+".tscn")
			####gettile = get_node("tile" + String(EnemyData.map[iii]))
			var onetile = gettile.instance()
			onetile.position = iinst.position / 10
			onetile.scale.x = 2.5
			onetile.scale.y = 2.5
			iinst.add_child(onetile)
			####gettile.position = iinst.position
			#iinstwo.text = String(EnemyData.map[iii])
	#		draw_string(font, Vector2(600,600), "za");
		elif (iii % 4 == 1 && EnemyData.map[iii] > 0):
			gettile = load("res://src/Objects/deuxmille/tile"+String(EnemyData.map[iii])+".tscn")
			var onetile = gettile.instance()
			onetile.position = iinst.position / 10
			onetile.scale.x = 2.5
			onetile.scale.y = 2.5
			iinst.add_child(onetile)
			#iinstwo.text =  String(EnemyData.map[iii])
	#		draw_string(font, iinst.global_position, String(EnemyData.map[iii]));
		elif (iii % 4 == 2 && EnemyData.map[iii] > 0):
			gettile = load("res://src/Objects/deuxmille/tile"+String(EnemyData.map[iii])+".tscn")
			var onetile = gettile.instance()
			onetile.position = iinst.position / 10
			onetile.scale.x = 2.5
			onetile.scale.y = 2.5
			iinst.add_child(onetile)
			#iinstwo.text = String(EnemyData.map[iii])
	#		draw_string(font, iinst.global_position, String(EnemyData.map[iii]));
		elif (iii % 4 == 3 && EnemyData.map[iii] > 0):
			gettile = load("res://src/Objects/deuxmille/tile"+String(EnemyData.map[iii])+".tscn")
			var onetile = gettile.instance()
			onetile.position = iinst.position / 10
			onetile.scale.x = 2.5
			onetile.scale.y = 2.5
			iinst.add_child(onetile)
			#iinstwo.text = String(EnemyData.map[iii])
	#		draw_string(font, iinst.global_position, String(EnemyData.map[iii]));
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

	if (EnemyData.map[id] == 0):
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
	if (EnemyData.map[dest] == 0):
		return (1);
	if (EnemyData.map[dest] == EnemyData.map[id]):
		return (1);
	return (0);

func	board_move_tile(id, dir):
	var	dest;
	var	origin;

	dest = id + dir;
	origin = EnemyData.map[id];
	while (board_tile_may_move(id, dir) && origin == EnemyData.map[id]):
		the_graphical_part(dest, id, EnemyData.fancymap)
		EnemyData.map[dest] += EnemyData.map[id];
		EnemyData.map[id] = 0;
		id = dest;
		dest = id + dir;
	if (origin != EnemyData.map[id]):
		EnemyData.score += EnemyData.map[id];

func		board_move(dir):
	var	start;
	var	finish;
	var	id;

	start = 15 if (dir > 0) else 0;
	finish = -1 if (dir > 0) else 16;
	id = start;
	while (id != finish):
		if (EnemyData.map[id] > 0):
			board_move_tile(id, dir);
		id += 1 if (id < finish) else -1;
	board_spawn();
	board_verify();

func decision(d):
	board_move(EnemyData.direction[rosettepierrede[d]])
var rosettepierrede = {1: 0, -4: 3, 4: 2, -1: 1}
var translate = {0: "up", 1: "right", 2: "down", 3: "left"}
var moine = {"up": -4, "right": 1, "down": 4, "left": -1}
func getinput():
	if (Input.is_action_just_released("move_right") && EnemyData.direction_possible[0]):
		board_move(EnemyData.direction[0]);
	elif (Input.is_action_just_released("move_left") && EnemyData.direction_possible[1]):
		board_move(EnemyData.direction[1]);
	elif (Input.is_action_just_pressed("move_down") && EnemyData.direction_possible[2]):
		board_move(EnemyData.direction[2]);
	elif (Input.is_action_just_released("jump") && EnemyData.direction_possible[3]):
		board_move(EnemyData.direction[3]);
	#else if (c == 27)
	#	return (0);
	return (1);

func	display_board(winmill, trapped):
	return ft_board_appearance(winmill, trapped)

func _physics_process(delta: float) -> void:
	### getinput()
	if (display_board(winmill, trapped) == 0):
		if trapped == 0 && winmill:
			EnemyData.winmill = true
		else:
			EnemyData.trapped_for_good = 1
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
		var temp = fourpiece.instance() if data[index] == 4 else twopiece.instance()
		## rescale_pieces(temp)
		add_child(temp)
		EnemyData.fancymap[index] = temp
		temp.position = grid_to_pixel(Vector2(index % 4, index / 4))
	else:
		var this_piece = data[index]
		this_piece.move(grid_to_pixel(Vector2(which_one % 4, which_one / 4)))
		# au lieu de chercher dans les noeuds comme un neuneu
		if EnemyData.map[which_one] == EnemyData.map[index]:
			remove_and_clear(which_one)
			this_piece.remove()
			var tmp = this_piece.next_value
			var new_piece = tmp.instance()
			## rescale_pieces(new_piece) ## piece controle par le tween
			add_child(new_piece)
			EnemyData.fancymap[which_one] = new_piece
			new_piece.position = grid_to_pixel(Vector2(which_one % 4, which_one / 4))
		else:
			EnemyData.fancymap[which_one] = this_piece	
		EnemyData.fancymap[index] = null
			
func remove_and_clear(which_one):
	EnemyData.fancymap[which_one].remove()
	EnemyData.fancymap[which_one] = null

##func rescale_pieces(temp):
##	temp.scale.x = 2.5
##	temp.scale.y = 2.5

