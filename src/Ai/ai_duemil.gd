extends Node


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		randomize()
		indextorow()
		monotonicityvalues()

var idx2row = []
var possrow = []
var timeLimit = .18
var timeToPlayTheGame = 0.01 + 0.2
var timer = 0
var LARGENUM = 100000000
var directions = [1,-1,4,-4]
var monotonetable = {}
var difficulty = randi() % 1
var sodirections = {1: "move_right", -1: "move_left", 4: "move_down", -4: "jump"}
var translate = {0: "up", 1: "right", 2: "down", 3: "left"}
var moine = {"up": -4, "right": 1, "down": 4, "left": -1}
func letsgo(delta, res):
	timer += delta
	# Time Limit Before Losing
	######################Input.parse_input_event(ev)

	#var idx2row = []
	#########indextorow()
	##########monotonicityvalues()
	if timer >= timeToPlayTheGame:
		var roma
		if difficulty != 1:
			roma = getMove(EnemyData.map, delta)
			EnemyData.decision = roma
			res[0] = roma
		else:
			roma = nextMove([] + EnemyData.map)
			roma = moine[translate[roma]]
		#print(roma)
		#getinput(roma, delta)
		timer = 0 
		#if (display_board(winmill, trapped, delta) == 0):
		#	if trapped == 0 && winmill:
		#		EnemyData.winmill = true
		#	else:
		#		EnemyData.trapped_for_good = 1
	######################simulate_key(sodirections[roma])
	


func monotonicityvalues():
	#var monotonetable = {}
	for possrow in idx2row:
		var left = 0
		var right = 0
		var monotone = 0
		var monotoneright = 0
		for y in range(3):
			if possrow[y]!=0 and possrow[y] >= possrow[y+1]:
				monotone += 1
				left += 4*(pow(monotone, 2))
			else:
				left -= abs(possrow[y]- possrow[y+1]) * 1.5
				monotone = 0
			if possrow[y] <= possrow[y+1] and possrow[y+1]:
				monotoneright += 1
				right += 4*(pow(monotoneright, 2))
			else:
				right -= abs(possrow[y]- possrow[y+1]) * 1.5
				monotoneright = 0
		monotonetable[str(possrow)] = Vector2(left, right)

func heuristic_monotone(grid):
	var left = 0
	var right = 0
	var up = 0
	var down = 0
	var leftright = 0
	var updown = 0
	var a = [] + grid
	var grid2 = []
	var grid_rescue = []
	#grid_rescue.append(String(grid[12]), String(grid[13]), String(grid[14]), String(grid[15]))
	#grid_rescue.append(String(grid[8]), String(grid[9]), String(grid[10]), String(grid[11]))
	#grid_rescue.append(String(grid[4]), String(grid[5]), String(grid[6]), String(grid[7]))
	#grid_rescue.append(String(grid[0]), String(grid[1]), String(grid[2]), String(grid[3]))
	#grid2.append(String(a[3]), String(a[7]), String(a[11]), String(a[15]))
	#grid2.append(String(a[2]), String(a[6]), String(a[10]), String(a[14]))
	#grid2.append(String(a[1]), String(a[5]), String(a[9]), String(a[13]))
	#grid2.append(String(a[0]), String(a[4]), String(a[8]), String(a[12]))
	grid_rescue.append(str([grid[0], grid[1], grid[2], grid[3]]))
	grid_rescue.append(str([grid[4], grid[5], grid[6], grid[7]]))
	grid_rescue.append(str([grid[8], grid[9], grid[10], grid[11]]))
	grid_rescue.append(str([grid[12], grid[13], grid[14], grid[15]]))
	grid2.append(str([a[3], a[7], a[11], a[15]]))
	grid2.append(str([a[2], a[6], a[10], a[14]]))
	grid2.append(str([a[1], a[5], a[9], a[13]]))
	grid2.append(str([a[0], a[4], a[8], a[12]]))
	for x in range(4):
		var leftiter = monotonetable[grid_rescue[x]].x
		var rightiter = monotonetable[grid_rescue[x]].y
		left += leftiter
		right += rightiter
		var Upiter = monotonetable[grid2[x]].x
		var Downiter = monotonetable[grid2[x]].y
		up += Upiter
		down += Downiter
	return max(up, down) + max(left, right)

# we use this to evaluate terminal nodes or any nodes
func heuristic(grid):
	var availcells = 0
	for a in grid:
		if a == 0:
			availcells += 1
	var nonempty = 16-availcells
	return heuristic_monotone(grid)+heuristic_smoothness(grid)-pow(nonempty, 2)

# eval for smoothness
func heuristic_smoothness(grid):
	var v1 = grid[0]
	var v2 = grid[1]
	var v3 = grid[2]
	var v4 = grid[3]
	var v5 = grid[4]
	var v6 = grid[5]
	var v7 = grid[6]
	var v8 = grid[7]
	var v9 = grid[8]
	var v10 = grid[9]
	var v11 = grid[10]
	var v12 = grid[11]
	var v13 = grid[12]
	var v14 = grid[13]
	var v15 = grid[14]
	var v16 = grid[15]
	for v in [v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16]:
		if v == 0:
			v = 2
	var smoothness = - min(abs(v1-v2), abs(v1-v5)) - min(abs(v2-v1), min(abs(v2-v6), abs(v2-v3))) - min(abs(v3-v2), min(abs(v3-v7), abs(v3-v4))) - min(abs(v4-v3), abs(v4-v8))
	smoothness = smoothness - min(abs(v5-v1), min(abs(v5-v6), abs(v5-v9))) - min(abs(v6-v2), min(abs(v6-v5), min(abs(v6-v7), abs(v6-v10)))) - min(abs(v7-v3), min(abs(v7-v6), min(abs(v7-v8), abs(v7-v11)))) - min(abs(v8-v4), min(abs(v8-v7), abs(v8-v12)))
	smoothness = smoothness - min(abs(v9-v5), min(abs(v9-v10), abs(v9-v13)))- min(abs(v10-v6), min(abs(v10-v9), min(abs(v10-v11), abs(v10-v14)))) - min(abs(v11-v7), min(abs(v11-v10), min(abs(v11-v12), abs(v11-v15))))- min(abs(v12-v8), min(abs(v12-v11), abs(v12-v16)))
	smoothness = smoothness - min(abs(v13-v14), abs(v13-v9)) - min(abs(v14-v13), min(abs(v14-v10), abs(v14-v15))) - min(abs(v15-v14), min(abs(v15-v11), abs(v15-v16))) - min(abs(v16-v15), abs(v16-v12))
	return smoothness

# check if over time
func overtime(currTime, prevTime):
	if currTime - prevTime > timeLimit:
		var over = true
		return true
	else:
		return false

#build out all possible row values
func indextorow():
	var posstiles = []

	for n in range(1, 16):
		posstiles.append(pow(2, n))
	posstiles.append(0)
	for p1 in posstiles:
		#possrow =""
		possrow=[]
		for p2 in posstiles:
			#possrow =""
			possrow=[]
			for p3 in posstiles:
				#possrow=""
				possrow=[]
				for p4 in posstiles:
					#possrow=""
					possrow=[]
					possrow.append(p1)
					possrow.append(p2)
					possrow.append(p3)
					possrow.append(p4)
					#possrow = String(p1)+String(p2)+String(p3)+String(p4)
					idx2row.append(possrow)

#includes both the minimize and expectation steps; and alpha beta pruning
func expectiminimax(grid, level, probofnode, alpha, beta, prevTime):
	if level == 0 or overtime(OS.get_system_time_msecs(), prevTime):
		return heuristic(grid)
	var numEmpty = 0
	var newgridrow = []
	for o in range(16):
		if grid[o] == 0:
			numEmpty += 1
	var worst_utility = LARGENUM
	for r in range(16):
			if grid[r] !=0: #focus on empty cells
				continue
			var i = 0
			if r < 4:
				i = 0
			elif r > 3 and r < 8:
				i = 4
			elif r > 7 and r < 12:
				i = 8
			elif r > 11:
				i = 12
			newgridrow = []
			newgridrow.append(grid[i]) #the row in the grid
			newgridrow.append(grid[i + 1]) #the row in the grid
			newgridrow.append(grid[i + 2]) #the row in the grid
			newgridrow.append(grid[i + 3]) #the row in the grid
			var utility = 0
			var totalprobability = 0
			var probability = [0.1, 0.9]
			var tilevalue = [4, 2]
			for lambda in range(2):
				var pp = probability[lambda]*probofnode
				if 0.9 * pp < 0.1 and numEmpty > 4 :
					continue
				newgridrow[r % 4] = tilevalue[lambda]
				#newgridrow[1] = tilevalue[lambda] ## pas encore sur apres 0
				#newgridrow[2] = tilevalue[lambda]
				#newgridrow[3] = tilevalue[lambda]
				grid[i] = newgridrow[0]
				grid[i + 1] = newgridrow[1]
				grid[i + 2] = newgridrow[2]
				grid[i + 3] = newgridrow[3]
				utility += probability[lambda] *maximize(grid, level, pp, alpha, beta, prevTime)
				totalprobability+=probability[lambda]
			newgridrow[r % 4] = 0 #changed it back!
			#newgridrow[1] = 0 #changed it back!
			#newgridrow[2] = 0 #changed it back!
			#newgridrow[3] = 0 #changed it back!
			grid[i] = newgridrow[0]
			grid[i + 1] = newgridrow[1]
			grid[i + 2] = newgridrow[2]
			grid[i + 3] = newgridrow[3] #changed it back!
			if totalprobability == 0:
				utility = heuristic(grid)
			else:
				utility /=totalprobability
			if utility < worst_utility:
				worst_utility = utility
			if worst_utility <= alpha:
				break
			if worst_utility < beta:
				beta = worst_utility
	return worst_utility

#maximization step
func maximize(grid, level, probofnode, alpha, beta, prevTime):
	var maxUtility = -LARGENUM
	for d in directions:
		var g2 = [] + grid
		var successful = board_move(g2, d)[0]
		if not successful:
			continue
		var utility = expectiminimax(g2, level -1, probofnode, alpha, beta, prevTime)
		if utility> maxUtility:
			maxUtility = utility
		if maxUtility >= beta:
			break
		if maxUtility > alpha:
			alpha = maxUtility
	return maxUtility

#func nexMovRecur(board,depth,maxDepth,prevTime,base=0.89):
#	var bestScore = -1.0
#	var bestMove = 0
#	#var newBoard = [] + board
#	for m in directions:
#		var boardille = [] + board
#		if board_move(boardille, m)[0]:
#			print(String(m)+"MP")
#			var newBoard = [] + board
#			board_move([]+newBoard, m)
#
#			var score = EnemyData.simulation_score#AI.evaluate(newBoard)
#			if depth != 0 and not overtime(OS.get_system_time_msecs(),prevTime):
#				var theList = nexMovRecur(newBoard,depth-1,maxDepth,prevTime)
#				score += theList[1]*pow(base,maxDepth-depth+1)
#			#print("HOOHO+String()"+String(score)+"OK"+String(bestScore))
#			if(score > bestScore):
#				bestMove = m
#				bestScore = score
#	return [bestMove,bestScore];
# most importantly, give the next move
func getMove(gridomegazz, delta, recursion_depth=3):
#	var prevTime = OS.get_system_time_msecs()
#	var theList = nexMovRecur([] + gridomegazz, recursion_depth, recursion_depth, prevTime)
#	var decision = theList[0]
	var prevTime = OS.get_system_time_msecs()
	var maxUtility = -LARGENUM
	var decision = directions[randi() % len(directions)]
	var alpha = -LARGENUM
	var beta = LARGENUM
	var grid = [] + gridomegazz
#
	for d in directions:
		var g2 = [] + grid
		var successful = board_move(g2, d)[0]
		if not successful:
#	#		print("no")
			continue
		var utility = expectiminimax(g2, 2 - 1, 1.0, alpha, beta, prevTime)
		if utility > maxUtility:
			maxUtility = utility
			decision = d
		if maxUtility >= beta:
			break
		if maxUtility > alpha:
			alpha = maxUtility
	#print("limit")
	#print(str(decision) + "ok")
	return decision
	

#
### IA ##
#func eval(grid):
#  var emptyCells = 0;
#  for g in grid:
#   if g == 0:
#    emptyCells += 1
#
#  var smoothWeight = 0.1
#      #monoWeight   = 0.0,
#      #islandWeight = 0.0,
#  var    mono2Weight  = 1.0
#  var    emptyWeight  = 2.7
#  var    maxWeight    = 1.0
#
#  return smoothness() * smoothWeight
#       #+ this.grid.monotonicity() * monoWeight
#       #- this.grid.islands() * islandWeight
#  + monotonicity2() * mono2Weight
#  + Math.log(emptyCells) * emptyWeight
#  + maxValue() * maxWeight;
#
## alpha-beta depth first search
#func search(depth, alpha, beta, positions, cutoffs):
#  var bestScore;
#  var bestMove = -1;
#  var result;
#
#  # the maxing player
#  if (this.grid.playerTurn):
#    bestScore = alpha;
#    for direction in directions:
#      var newGrid = this.grid.clone();
#      if (newGrid.move(direction).moved):
#        positions+=1
#        if (newGrid.isWin()):
#          return { move: direction, score: 10000, positions: positions, cutoffs: cutoffs };
#
#        var newAI = [] + grid;
#
#        if (depth == 0):
#          result = { move: direction, score: newAI.eval() }; 
#        else:
#          result = newAI.search(depth-1, bestScore, beta, positions, cutoffs);
#          if (result.score > 9900): # win
#            result.score-=1; # to slightly penalize higher depth from win
#
#          positions = result.positions;
#          cutoffs = result.cutoffs;
#
#        if (result.score > bestScore):
#          bestScore = result.score;
#          bestMove = direction;
#
#        if (bestScore > beta):
#          cutoffs+=1
#          return { "move": bestMove, "score": beta, "positions": positions, "cutoffs": cutoffs }
#
#  else: # computer's turn, we'll do heavy pruning to keep the branching factor low
#    bestScore = beta;
#
#    #try a 2 and 4 in each cell and measure how annoying it is
#    #with metrics from eval
#    var candidates = [];
#    var cells = this.grid.availableCells();
#    var scores = { 2: [], 4: [] };
#    for value in scores:
#      for i in cells:
#        scores[value].push(null);
#        var cell = cells[i];
#        var tile = Tile(cell, parseInt(value, 10));
#        this.grid.insertTile(tile);
#        scores[value][i] = -this.grid.smoothness() + this.grid.islands();
#        this.grid.removeTile(cell);
#
#    #now just pick out the most annoying moves
#    var maxScore = Math.max(Math.max.apply(null, scores[2]), Math.max.apply(null, scores[4]));
#    for value in scores: # 2 and 4
#      for i in len(scores[value]):
#        if (scores[value][i] == maxScore):
#          candidates.push( { position: cells[i], value: parseInt(value, 10) } );
#
#    #search on each candidate
#    for i in len(candidates):
#      var position = candidates[i].position;
#      var value = candidates[i].value;
#      var newGrid = this.grid.clone();
#      var tile = Tile(position, value);
#      newGrid.insertTile(tile);
#      newGrid.playerTurn = true;
#      positions+=1;
#      newAI = AI(newGrid);
#      result = newAI.search(depth, alpha, bestScore, positions, cutoffs);
#      positions = result.positions;
#      cutoffs = result.cutoffs;
#
#      if (result.score < bestScore):
#        bestScore = result.score;
#      if (bestScore < alpha):
#        cutoffs+=1;
#        return { move: null, score: alpha, positions: positions, cutoffs: cutoffs };
#
#  return { move: bestMove, score: bestScore, positions: positions, cutoffs: cutoffs };
#
## performs a search and returns the best move
#func getBest():
#  return iterativeDeep();
#
## performs iterative deepening over the alpha-beta search
#func iterativeDeep():
#  var start = ( Date()).getTime();
#  var depth = 0;
#  var best;
#  while OS.get: 
#  #do {
#    var newBest = this.search(depth, -10000, 10000, 0 ,0);
#    if (newBest.move == -1):
#      break;
#    else:
#      best = newBest;
#    depth+=1;
#  #} while ( (new Date()).getTime() - start < minSearchTime);
#  return best
#
### AI ##














	
func	board_tile_may_move(g2, id, dir):
	var	dest;

	if (g2[id] == 0):
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
	if (g2[dest] == 0):
		return (1);
	if (g2[dest] == g2[id]):
		return (1);
	return (0);

func	board_move_tile(g2, id, dir, moved):
	var	dest;
	var	origin;

	dest = id + dir;
	origin = g2[id];
	while (board_tile_may_move(g2, id, dir) == 1 && origin == g2[id]):
		g2[dest] += g2[id];
		g2[id] = 0;
		id = dest;
		dest = id + dir;
		moved = [true, g2]
	if (origin != g2[id]):
		EnemyData.simulation_score += g2[id];
	return moved

func		board_move(g2, dir):
	var	start;
	var	finish;
	var	id;
	var moved = [false, g2]

	start = 15 if (dir > 0) else 0;
	finish = -1 if (dir > 0) else 16;
	id = start;
	while (id != finish):
		if (g2[id] > 0):
			moved = board_move_tile(g2, id, dir, moved);
		id += 1 if (id < finish) else -1;
	return moved










var GAME_SIZE = 4

var WIN_VALUE = 2048
var winmill = false
var trapped = 0
#var iii
#var iinst
#var font
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
			if (board_tile_may_move_mine(id, EnemyData.direction[dir])):
				EnemyData.direction_possible[dir] = 1
			id += 1
		if EnemyData.direction_possible[dir]:
			EnemyData.trapped = 0
		dir += 1
	#board->color = board->trapped ? 4 : 5 + board->victory;
func middle(el):
	var middle_position = el.position# + el.scale * el.shape.extents/2
	return middle_position	
func instantatiate_with_scale_and_position(gettile):
	var onetile = gettile.instance()
	onetile.position = Vector2(0,0)
	onetile.scale.x = 2.5
	onetile.scale.y = 2.5
	return onetile
func board_done(content, spawn, sonic, after):
	var b = {}
	var kw = {}
	#var two = deep_copy(content)
	print("nou")
	for k in content:
		print(k)
		print(content[k])
		var iii = k
		iii = content[k] if after == 1 else iii
		var dest = content[k]
		var onode = "OPOS" + String(iii)
		var iinst = get_main_node().get_node("Symbols/Symbol2/" + onode)
		#if spawn:
		for child in get_main_node().get_node("Symbols/Symbol2").get_children():##in iinst.get_children():
			if "tile" and "@" in child.get_name():
				if iinst.position - child.position <= Vector2(0.01, 0.01):
					kw[iii] = child
				break
		if spawn:
				#if EnemyData.map[iii] == 0:
				#	child.queue_free()
				#elif String(EnemyData.map[iii]) != child.get_name().replace("tile", ""):
				#	child.queue_free()
			var gettile = load("res://src/Objects/deuxmille/tile"+String(EnemyData.map[iii])+".tscn")
			var onetile = instantatiate_with_scale_and_position(gettile)
			onetile.position = middle(iinst)
			get_main_node().get_node("Symbols/Symbol2").add_child(onetile)
			onetile.add(0)
			yield(onetile, "tree_exited")
			onetile = instantatiate_with_scale_and_position(gettile)
			get_main_node().get_node("Symbols/Symbol2").add_child(onetile)#iinst.position/10
			onetile.position = middle(iinst)
		else:
			if EnemyData.map[dest] == 2:
				#for child in get_main_node().get_node("Symbols/Symbol2").get_children():#in iinst.get_children():
					onode = "OPOS" + String(dest)
					var iiinst = get_main_node().get_node("Symbols/Symbol2/" + onode)
					if kw.has(iii):
						print(iii)
						print(dest)
						print(kw[iii].position)
						print(kw[iii].global_position)
						print(kw[iii].get_name())
						print(iiinst.position)
						print(iiinst.global_position)
						b[kw[iii].get_name()] = middle(iiinst)
					#b[String(iii)] = middle(iiinst)
			else:
				#for child in get_main_node().get_node("Symbols/Symbol2").get_children():#in iinst.get_children():
					onode = "OPOS" + String(dest)
					var iiinst = get_main_node().get_node("Symbols/Symbol2/" + onode)
					if kw.has(iii):
						b[kw[iii].get_name()] = middle(iiinst)
					#b[String(iii)] = middle(iiinst)
	#yield()
	if !spawn:
		var ok = deep_copy(content)
		EnemyData.whowhere = b
#		for k in ok:
#			#if not k in b.keys():
#			#	continue
#			var iii = k #if after == 1 else 
#			var dest = ok[k]
#			var onode = "OPOS" + String(iii)
#			var onodee = "OPOS" + String(dest)
#			var iinst = get_main_node().get_node("Symbols/Symbol2/" + onode)
#			var iiinst = get_main_node().get_node("Symbols/Symbol2/" + onodee)
#			if !spawn and EnemyData.map[dest]:
#				for child in get_main_node().get_node("Symbols/Symbol2").get_children():
##					pass
#					if child and child.get_name() in b.keys() and "@" in child.get_name():
#						yield(child, "tree_exited")
#						child.queue_free()
##						if EnemyData.whowhere[child.get_name()]:
##							pass
#					#if EnemyData.map[iii] == 0:
#					#	child.queue_free()
#					#if String(EnemyData.map[dest]) != child.get_name().replace("tile", ""):
#						#child.queue_free()#remplace que si remplace
#
#						var gettile = load("res://src/Objects/deuxmille/tile"+String(EnemyData.map[dest])+".tscn")
#						var onetile = instantatiate_with_scale_and_position(gettile)
#						get_main_node().get_node("Symbols/Symbol2").add_child(onetile)
#						onetile.position = middle(iiinst)
		#board_done(content, 1, sonic, 1)
static func deep_copy(v):
	var t = typeof(v)

	if t == TYPE_DICTIONARY:
		var d = {}
		for k in v:
			d[k] = deep_copy(v[k])
		return d

	elif t == TYPE_ARRAY:
		var d = []
		d.resize(len(v))
		for i in range(len(v)):
			d[i] = deep_copy(v[i])
		return d

	elif t == TYPE_OBJECT:
		if v.has_method("duplicate"):
			return v.duplicate()
		else:
			print("Found an object, but I don't know how to copy it!")
			return v

	else:
		# Other types should be fine,
		# they are value types (except poolarrays maybe)
		return v
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
			## the_graphical_part(21, i, EnemyData.map)
			## board_done({i: 0}, 1, 0, 0)
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
	EnemyData.fancymap.resize(16)
	var i = 0;
	EnemyData.map.resize(16)
	while (i < 16):
		EnemyData.fancymap[i] = 0
		EnemyData.src.append(0)
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

func get_inside(emptycase,iinst,iii,onode,onetile, sonic):
	if emptycase:
		if iinst.get_child_count() != 0:
			for child in iinst.get_children():
				#if EnemyData.src[iii]:
				onode = "OPOS" + String(EnemyData.src[iii])
				var iiinst = get_main_node().get_node("Symbols/Symbol2/" + onode)
				child.position = child.position.linear_interpolate(iiinst.position / 10, sonic)				
				child.queue_free()
		else:
			pass
	else:
		if iinst.get_child_count() != 0:
			for child in iinst.get_children():
				if child.get_name().replace("tile","") != String(EnemyData.map[iii]):
					if EnemyData.src[iii]:
						onode = "OPOS" + String(EnemyData.src[iii])
						var iiinst = get_main_node().get_node("Symbols/Symbol2/" + onode)
						for chiild in iiinst.get_children():
							child.position = child.position.linear_interpolate(chiild.position / 10, sonic)
							child.queue_free()								
					else:
						child.queue_free()
						iinst.add_child(onetile)
				else:
					for chilt in iinst.get_children():
						#if EnemyData.src[iii]:
						onode = "OPOS" + String(EnemyData.src[iii])
						var iiinst = get_main_node().get_node("Symbols/Symbol2/" + onode)
						chilt.position = chilt.position.linear_interpolate(iiinst.position / 10, sonic)				
						chilt.queue_free()
					
		else:
			iinst.add_child(onetile)
		

func get_into_it(iinst, iii, onode, onetile, emptycase, sonic):
	if !emptycase: #inst add child onetiler
		get_inside(0, iinst, iii, onode, onetile, sonic)
	else:
		get_inside(1, iinst, iii, onode, onetile, sonic)

func dioudz(sonic):
	#var labelone = get_node("label1")
	#var font = labelone.get_font("")

	var iii = 0;
	while (iii < 16):
		var onode = "OPOS" + String(iii)
		#var iinstwo = get_node("Label"+ String(iii))
		#iinstwo.text = ""
		var gettile = ""
		var onetile = ""
		var iinst = get_main_node().get_node("Symbols/Symbol2/" + onode)
		##if EnemyData.map[iii] == 0:
		##		for i in iinst.get_children():
		##			i.queue_free()
		#for child in iinst.get_children():
		#	child.queue_free()
			#child.position = child.position.linear_interpolate(onetile.position, speed)
		if (iii % 4 == 0 && EnemyData.map[iii] > 0): # 1ere colonne etc
			gettile = load("res://src/Objects/deuxmille/tile"+String(EnemyData.map[iii])+".tscn")
			####gettile = get_node("tile" + String(EnemyData.map[iii]))
			onetile = gettile.instance()
			onetile.position = iinst.position / 10
			onetile.scale.x = 2.5
			onetile.scale.y = 2.5
			get_into_it(iinst, iii, onode, onetile, 0, sonic)
			####gettile.position = iinst.position
			#iinstwo.text = String(EnemyData.map[iii])
	#		draw_string(font, Vector2(600,600), "za");
		elif (iii % 4 == 1 && EnemyData.map[iii] > 0):
			gettile = load("res://src/Objects/deuxmille/tile"+String(EnemyData.map[iii])+".tscn")
			onetile = gettile.instance()
			onetile.position = iinst.position / 10
			onetile.scale.x = 2.5
			onetile.scale.y = 2.5
			get_into_it(iinst, iii, onode, onetile, 0, sonic)
			#iinstwo.text =  String(EnemyData.map[iii])
	#		draw_string(font, iinst.global_position, String(EnemyData.map[iii]));
		elif (iii % 4 == 2 && EnemyData.map[iii] > 0):
			gettile = load("res://src/Objects/deuxmille/tile"+String(EnemyData.map[iii])+".tscn")
			onetile = gettile.instance()
			onetile.position = iinst.position / 10
			onetile.scale.x = 2.5
			onetile.scale.y = 2.5
			get_into_it(iinst, iii, onode, onetile, 0, sonic)
			#iinstwo.text = String(EnemyData.map[iii])
	#		draw_string(font, iinst.global_position, String(EnemyData.map[iii]));
		elif (iii % 4 == 3 && EnemyData.map[iii] > 0):
			gettile = load("res://src/Objects/deuxmille/tile"+String(EnemyData.map[iii])+".tscn")
			onetile = gettile.instance()
			onetile.position = iinst.position / 10
			onetile.scale.x = 2.5
			onetile.scale.y = 2.5
			get_into_it(iinst, iii, onode, onetile, 0, sonic)
			#iinstwo.text = String(EnemyData.map[iii])
	#		draw_string(font, iinst.global_position, String(EnemyData.map[iii]));
		elif EnemyData.map[iii] == 0:
			get_into_it(iinst, iii, onode, onetile, 1, sonic)
		iii += 1
			

func	ft_numbs(sonic, delta):
		#call_deferred("_draw")
		##_draw()
		##update()
		dioudz(sonic * delta * 2.5)

func		ft_board_appearance(winmill, trapped, delta):
	var	i;

	i = 0;
	#ft_numbs(4, delta);
	return refresh_lives_level_and_score(winmill, trapped);

func	board_tile_may_move_mine(id, dir):
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

func	board_move_tile_mine(id, dir, delta, content):
	var	dest;
	var	origin;

	dest = id + dir;
	origin = EnemyData.map[id];
	while (board_tile_may_move_mine(id, dir) && origin == EnemyData.map[id]):
		## the_graphical_part(dest, id, EnemyData.fancymap)
		EnemyData.map[dest] += EnemyData.map[id];
		EnemyData.map[id] = 0;
		content[id] = dest
		id = dest;
		dest = id + dir;
	if (origin != EnemyData.map[id]):
		EnemyData.score += EnemyData.map[id];

func		board_move_mine(dir, delta):
	var	start;
	var	finish;
	var	id;
	var content = {}

	start = 15 if (dir > 0) else 0;
	finish = -1 if (dir > 0) else 16;
	id = start;
	while (id != finish):
		if (EnemyData.map[id] > 0):
			board_move_tile_mine(id, dir, delta, content);
		id += 1 if (id < finish) else -1;
	board_done(content, 0, delta, 0)
	board_spawn();
	board_verify();



func getinput(c, delta):
	if (c == 1 && EnemyData.direction_possible[0]):
		board_move_mine(EnemyData.direction[0], delta);
	elif (c == -1 && EnemyData.direction_possible[1]):
		board_move_mine(EnemyData.direction[1], delta);
	elif (c == 4 && EnemyData.direction_possible[2]):
		board_move_mine(EnemyData.direction[2], delta);
	elif (c == -4 && EnemyData.direction_possible[3]):
		board_move_mine(EnemyData.direction[3], delta);
	#else if (c == 27)
	#	return (0);
	return (1);

func	display_board(winmill, trapped, delta):
	return ft_board_appearance(winmill, trapped, delta)

#func _physics_process(delta: float) -> void:
#	getinput()
#	if (display_board(winmill, trapped) == 0):
#		if trapped == 0 && winmill:
#			EnemyData.winmill = true
#		else:
#			EnemyData.trapped_for_good = 1
#			pass
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


#func the_graphical_part(which_one, index, data):
#	if which_one == 21:
#		var temp = fourpiece.instance() if data[index] == 4 else twopiece.instance()
#		rescale_pieces(temp)
#		add_child(temp)
#		EnemyData.fancymap[index] = temp
#		temp.position = grid_to_pixel(Vector2(index % 4, index / 4))
#	else:
#		var this_piece = data[index]
#		this_piece.move(grid_to_pixel(Vector2(which_one % 4, which_one / 4)))
#		# au lieu de chercher dans les noeuds comme un neuneu
#		if EnemyData.map[which_one] == EnemyData.map[index]:
#			remove_and_clear(which_one)
#			this_piece.remove()
#			var tmp = this_piece.next_value
#			var new_piece = tmp.instance()
#			rescale_pieces(new_piece)
#			add_child(new_piece)
#			EnemyData.fancymap[which_one] = new_piece
#			new_piece.position = grid_to_pixel(Vector2(which_one % 4, which_one / 4))
#		else:
#			EnemyData.fancymap[which_one] = this_piece	
#		EnemyData.fancymap[index] = null
			
func remove_and_clear(which_one):
	EnemyData.fancymap[which_one].remove()
	EnemyData.fancymap[which_one] = null

func rescale_pieces(temp):
	temp.scale.x = 2.5
	temp.scale.y = 2.5

	
	
	
	
	
	
	
	
	
	# This AI follows a hard-coded strategy based on the programmer's experience.
# It is not a trained AI.

var GoalType = { "UNDEFINED": -1, "BUILD": 0, "SHIFT": 1, "MOVE": 2 };

#Goal = function() {
#};
#Goal.prototype = {
#  type: GoalType.UNDEFINED
#};
#
#SmartAI = function(game) {
#  this.game = game;
#};
func updateCells(cells, grid):
		
	var i = 0
	for a in grid:
	  cells[i / 4][i % 4] = {"x": i/4, "y": i%4, "value": a}
	  i += 1
	return cells

func nextMove(grid):

	var cells = init_cells()
	cells = updateCells(cells, grid)
#   Determine the best move given the current game state
#  // Use a couple of stragtegies:
#  // 1. Goals:
#  //   - Determine the main goal given the current board state
#  //     (e.g. if the highest number is 64, build it up to 128)
#  //   - Determine sub-goals that must happen to achieve that goal
#  // 2. Planning ahead
#  //   - in some cases, the AI should plan ahead a certain number of
#  //     moves to determine the effect of each possible move it can make.
#  //     If it sees that a certain move will put the board in a bad state
#  //     (i.e. forced to push the wrong direction), then it will avoid that
#  //     move. Alternatively, if it sees a sequence of moves that will 
#  //     accomplish a goal, it will do those moves.
#  /*var goal = this.determineGoal(this.game.grid);
#  // Keep looking at sub-goals until we find a sub-goal that is a simple movement.
#  while (goal.type != GoalType.MOVE) {
#    goal = this.determineSubGoal(this.game.grid, goal);
#  }
#
#  if (goal.directions) {
#    // Move in the most optimal legal direction.
#    for (var i = 0; i < goal.directions.length; i++) {
#      if (this.game.moveAvailable(goal.directions[i])) {
#        return goal.directions[i];
#      }
#    }
#  }*/
#
#  // Plan ahead a few moves in every direction and analyze the board state.
#  // Go for moves that put the board in a better state.
	var originalQuality = gridQuality(cells);
	var prevTime = OS.get_system_time_msecs()
	var results = planAhead(cells, 3, originalQuality, grid, prevTime);
#  // Choose the best result
	var bestResult = chooseBestMove(results, originalQuality);
	
	return bestResult.direction;
func init_results(arr):
	for i in range(4):
		arr.append(null)
#// Plans a few moves ahead and returns the worst-case scenario grid quality,
#// and the probability of that occurring, for each move
func planAhead(grid, numMoves, originalQuality, origin, prevTime):
	var results = []
	init_results(results)
#  // Try each move and see what happens.
	for d in range(4):
#    // Work with a clone so we don't modify the original grid.
		var testGrid = [] + grid
		##var testGame = new GameController(testGrid);
		var moved = board_move(origin, moine[translate[d]])#testGame.moveTiles(d);

		if (!moved[0]):
		  results[d] = null;
		  continue;
		testGrid = updateCells(testGrid, moved[1])
	#    // Spawn a 2 in all possible locations.
		var result = {
		  "quality": -1,    #// Quality of the grid
		  "probability": 1, #// Probability that the above quality will happen
		  "qualityLoss": 0, #// Sum of the amount that the quality will have decreased multiplied by the probability of the decrease
		  "direction": d
		};
		var availableCells = availableCells(testGrid);
		for i in len(availableCells):
		  #// Assume that the worst spawn location is adjacent to an existing tile,
		  #// and only test cells that are adjacent to a tile.
			var hasAdjacentTile = false;
			for d2 in range(4):
				var vector = getVector(d2);
				var adjCell = {
				  "x": availableCells[i].x + vector.x,
				  "y": availableCells[i].y + vector.y,
				};
				if (cellContent(adjCell, grid)):
				  hasAdjacentTile = true;
				  break;
			
			if (!hasAdjacentTile):
				continue;

			var testGrid2 = [] + testGrid
			## var testGame2 = new GameController(testGrid2)
			testGrid2 = addTile({"x": availableCells[i].x, "y": availableCells[i].y, "value": 2}, testGrid2);
			var tileResult;
			if (numMoves > 1):# and ! overtime(OS.get_system_time_msecs(), prevTime)):
				var subResults = planAhead(testGrid2, numMoves - 1, originalQuality, origin, prevTime);
				#// Choose the sub-result with the BEST quality since that is the direction
				#// that would be chosen in that case.
				tileResult = chooseBestMove(subResults, originalQuality);
			else:
				var tileQuality = gridQuality(testGrid2);
				tileResult = {
				  "quality": tileQuality,
				  "probability": 1,
				  "qualityLoss": max(originalQuality - tileQuality, 0)
				};
				
			  #// Compare this grid quality to the grid quality for other tile spawn locations.
			  #// Take the WORST quality since we have no control over where the tile spawns,
			  #// so assume the worst case scenario.
			if (result.quality == -1 || tileResult.quality < result.quality):
				result.quality = tileResult.quality;
				result.probability = tileResult.probability / len(availableCells);
			elif (tileResult.quality == result.quality):
				result.probability += tileResult.probability / len(availableCells);

			result.qualityLoss += tileResult.qualityLoss / len(availableCells);

		results[d] = result

	return results;

func chooseBestMove(results, originalQuality):
  #// Choose the move with the least probability of decreasing the grid quality.
  #// If multiple results have the same probability, choose the one with the best quality.
	var bestResult;
	for i in range (len(results)):  
		if (results[i] == null):
			continue;
		if (!bestResult ||
			results[i].qualityLoss < bestResult.qualityLoss ||
			(results[i].qualityLoss == bestResult.qualityLoss && results[i].quality > bestResult.quality) ||
			(results[i].qualityLoss == bestResult.qualityLoss && results[i].quality == bestResult.quality && results[i].probability < bestResult.probability)):
			bestResult = results[i];
		
	if (!bestResult):
		bestResult = {
		  "quality": -1,
		  "probability": 1,
		  "qualityLoss": originalQuality,
		  "direction": 0
		};
	return bestResult;

func scoreCell(cell, score, cells):
	var tile = cellContent(cell, cells);
	var tileValue = (tile.value if tile else 0);
	score["incScore"] += tileValue
	if (tileValue <= score["prevValue"] || score["prevValue"] == -1):
		score["decScore"] += tileValue;
		if (tileValue < score["prevValue"]):
			score["incScore"] -= score["prevValue"];
	score["prevValue"] = tileValue;

func init_cells():
	var cells = []
	for i in range(GAME_SIZE):
		cells.append([])
		for j in range(GAME_SIZE):
			cells[i].append(0)
	return cells

#// Gets the quality of the current state of the grid
func gridQuality(cells):
#  /* Look at monotonicity of each row and column and sum up the scores.
#   * (monoticity = the amount to which a row/column is constantly increasing or decreasing)
#   *
#   * How monoticity is scored (may be subject to modification):
#   *   score += current_tile_value
#   *   -> If a tile goes againt the monoticity direction:
#   *      score -= max(current_tile_value, prev_tile_value)
#   *
#   * Examples:
#   *   2    128    64   32
#   *  +2     +0   +64  +32
#
#   *  32     64   128    2
#   * +32    +64  +128 -126
#   *
#   *   128   64   32   32
#   *  +128  +64  +32  +32
#   * 
#   *   ___  128   64   32
#   *    +0   +0  +64  +32
#   *
#   *   128   64   32  ___
#   *  +128  +64  +32
#   *
#   *   ___  128  ___  ___
#   *         +0
#   *
#   *   ___  128  ___  32
#   *         +0      +32
#   */
	var monoScore = 0; #// monoticity score
	var traversals = buildTraversals({"x": -1, "y":  0});
	var prevValue = -1;
	var incScore = 0
	var decScore = 0;

  
#  // Traverse each column
	for x in traversals.x:
	#prevValue = -1;
	#incScore = 0;
	#decScore = 0;
		var score = {"prevValue": -1, "incScore": 0, "decScore": 0}
		for y in traversals.y:
			scoreCell({ "x": x, "y": y }, score, cells);
		monoScore += max(score["incScore"], score["decScore"]);
##  // Traverse each row
	for y in traversals.y:
	#prevValue = -1;
	#incScore = 0;
	#decScore = 0;
		var score = {"prevValue": -1, "incScore": 0, "decScore": 0}
		for x in traversals.x:
			scoreCell({ "x": x, "y": y }, score, cells);
		monoScore += max(score["incScore"], score["decScore"]);
  
#  // Now look at number of empty cells. More empty cells = better.
	var availableCells = availableCells(cells);
	var emptyCellWeight = 8;
	var emptyScore = len(availableCells) * emptyCellWeight;
  
	var score = monoScore + emptyScore;
	return score;

#func getscorecell(cell):
#	var tile = cellContent(cell);
#	var tileValue = (tile.value if tile else 0);
#	incScore += tileValue;
#	if (tileValue <= prevValue || prevValue == -1):
#		decScore += tileValue;
#		if (tileValue < prevValue):
#			incScore -= prevValue;
#	prevValue = tileValue;
	
#// Determine the main (highest level) goal to accomplish for the current grid
func determineGoal(grid):
	var goal = []
	#  // Find the highest tile on the board.
	var maxValue = 0;
	var maxCells = [];
	for x in range(GAME_SIZE):
		for y in range(GAME_SIZE):
			if (grid[x][y] && grid[x][y] >= maxValue):
				if (grid[x][y] > maxValue):
					maxCells = [];
					maxValue = grid[x][y];
				maxCells.append({"x": x, "y": y});

	var maxCell;
	if (len(maxCells) == 1):
		maxCell = maxCells[0];
	else:
#    // If there are multiple cells with the highest value, choose the one closest to the corner
		var minDist = grid.size;
		for i in range(len(maxCell)):
			var dist = min(maxCells[i].x, grid.size - maxCells[i].x - 1)
			+ min(maxCells[i].y, grid.size - maxCells[i].y - 1);
			if (dist < minDist):
				minDist = dist;
				maxCell = maxCells[i];

#  // Find the distance of the max tile from the corner
	var dist = min(maxCell.x, grid.size - maxCell.x - 1)
	+ min(maxCell.y, grid.size - maxCell.y - 1);
	if (dist == 0):
#    // Great! The tile is in a corner.
#    // In this case, the goal is to double that tile's value.
		goal.type = GoalType.BUILD;
		goal.cell = maxCell;
		goal.value = maxValue * 2;
		return goal;

#  // Shoot, the highest tile is not in the corner.
#  // Find a way to get it in the corner.
	if (dist == 1):
		if (maxValue <= 512):
			#      // Option 1: build up the corner tile to have the same value as the max tile
			#      // This is only reasonable if the tile value is not greater than 512.
			goal.type = GoalType.BUILD;
			goal.cell = { "x": (0 if maxCell.x < grid.size / 2  else grid.size - 1),
					"y": (0 if maxCell.y < grid.size / 2 else grid.size - 1) };
			goal.value = maxValue;
			return goal;

#    // Things are looking pretty rough.
#    // Option 2: do some fancy moves to try and shift the max tile into a different corner.
#    // This is only reasonable if there are enough open cells.
		var availableCells = availableCells(grid);
		if (availableCells.length > 4):
#      // TODO: if the target cell is empty, just move! (don't shift)
			goal.type = GoalType.SHIFT;
			goal.fromCell = maxCell;
			if 1:#(maxCell.x == 0 || maxCell.x == game.size - 1):
				goal.cell = { "x": maxCell.x,
				  "y": (grid.size - 1 if maxCell.y < grid.size / 2 else 0) };
			else:
				goal.cell = { "x": (grid.size - 1 if maxCell.x < grid.size / 2 else 0),
				  "y": maxCell.y };

			return goal;

#    // Now things are looking REALLY rough.
#    // Option 3: Our best bet is to try and build up the max tile to clear up room on the board.
		goal.type = GoalType.BUILD;
		goal.cell = maxCell;
		goal.value = maxValue * 2;
		return goal;

#  // dist > 1
#  // The cell is really far from a corner, which sucks.
#  // Do some fancy moves to try and shift the max tile into a different corner.
	var availableCells = availableCells(grid);
	goal.type = GoalType.SHIFT;
	goal.fromCell = maxCell;
	goal.cell = { "x": maxCell.x,
				"y": (grid.size - 1 if maxCell.y < grid.size / 2 else 0) };
	return goal;

#// Determine the sub-goal required to achieve the current goal.
func determineSubGoal(grid, goal):
	var subgoal = [];
	if (goal.type == GoalType.BUILD):
		var tile = grid.cellContent(goal.cell);

		if (!tile):
		#      // Cell is empty. This is easy; just move a tile into that cell.
		  goal.type = GoalType.MOVE;
		  var vector = { "x": goal.cell.x - grid.size / 2,
					 "y": goal.cell.y - grid.size / 2 };
		  goal.directions = getDirections(vector);
		  return goal;

		#    // See if any adjacent cells have equal value.
		var adjacentCells
		adjacentCells.resize(4)
		for i in range(4):
			var vector = getVector(i);
			var adjCell = {"x": goal.cell.x + vector.x, "y": goal.cell.y + vector.y };
			var adjTile = grid.cellContent(adjCell);
			if (adjTile && adjTile.value == tile.value):
		#        // Adjacent tiles with equal value. Combine the tiles.
		#        // Flip the vector and use that as the direction.
				vector.x = -vector.x;
				vector.y = -vector.y;
				goal.type = GoalType.MOVE;
				goal.directions = getDirections(vector);
				return goal;
	
#    // No tiles to combine. Start building an adjacent tile.
	
  ##elif (goal.type == GoalType.MOVE)
	return subgoal;

#// Gets the direction of movement priority order given a vector
func getDirections(vector):
	directions = [0, 3, -1, -1];
	if (vector.x > 0):
		directions[0] = 2;
	
	if (vector.y > 0):
		directions[1] = 1;
	
	if (abs(vector.x) > abs(vector.y)):
		var temp = directions[0];
		directions[0] = directions[1];
		directions[1] = temp;
	
	directions[2] = (directions[1] + 2) % 4;
	directions[3] = (directions[0] + 2) % 4;


func availableCells(origin):
	var cells = [];

	for x in range(GAME_SIZE):
		for y in range(GAME_SIZE):
			if (!origin[x][y]):
				cells.append({ "x": x, "y": y });

	return cells;

# Call callback for every cell
#func eachCell(callback):
#  for x in range(size):
#    for y in range(size):
#      callback(x, y, this.cells[x][y]);
	
#	// Determine whether a move is available
func moveAvailable(direction):
  # 0: up, 1: right, 2: down, 3: left
  var tile;
#  var vector = getVector(direction);
#  for x in range(this.size):
#    for y in range(this.size):
#      tile = this.grid.cellContent({ x: x, y: y });
#
#      if (tile):
#        var cell   = { x: x + vector.x, y: y + vector.y };
#        if (!this.grid.withinBounds(cell)):
#          continue;
#
#        var otherTile  = this.grid.cellContent(cell);
#
#        # The current tile can be moved if the cell is empty or has the same value.
#        if (!otherTile || otherTile.value == tile.value):
#          return true;
  return false;

#// Adds a tile to the grid
func addTile(tile, grid):
	return insertTile(tile, grid);
	if (!movesAvailable(grid)):
		var over = true; #// Game over!

#// Get the vector representing the chosen direction
func getVector(direction):
 # // Vectors representing tile movement
  var map = {
	0: { "x": 0,  "y": -1 },# // Up
	1: { "x": 1,  "y": 0 },  #// Right
	2: { "x": 0,  "y": 1 },  #// Down
	3: { "x": -1, "y": 0 }   #// Left
  };

  return map[direction];

func movesAvailable(grid):
  return cellsAvailable(grid) || tileMatchesAvailable(grid);

#// Check for available matches between tiles (more expensive check)
func tileMatchesAvailable(grid):
  #var self = this;

	var tile;

	for x in range (GAME_SIZE):
		for y in range  (GAME_SIZE):
			tile = cellContent({ "x": x, "y": y }, grid);

			if (tile):
				for direction in range(4):
					var vector = self.getVector(direction);
					var cell   = { x: x + vector.x, y: y + vector.y };

					var other  = self.grid.cellContent(cell);

					if (other && other.value == tile.value):
						return true; #// These two tiles can be merged


	return false;

func withinBounds(position):
  return position.x >= 0 && position.x < GAME_SIZE && position.y >= 0 && position.y < GAME_SIZE;
		
#// Check if there are any cells available
func cellsAvailable(grid):
  return !!availableCells(grid).length;

#// Check if the specified cell is taken
func cellAvailable(cell, cells):
  return !cellOccupied(cell, cells);

func cellOccupied(cell, cells):
  return !!cellContent(cell, cells);


func cellContent(cell, cells):
	if (withinBounds(cell)):
		return cells[cell.x][cell.y];
	else:
		return null;
	
func insertTile(tile, cells):
  cells[tile.x][tile.y] = tile;
  return cells


#// Build a list of positions to traverse in the right order
func buildTraversals(vector):
	var traversals = { "x": [], "y": [] };

	for pos in range(GAME_SIZE):
		traversals.x.append(pos);
		traversals.y.append(pos);
  
  #// Always traverse from the farthest cell in the chosen direction
	if (vector.x == 1): traversals.x = traversals.x.reverse();
	if (vector.y == 1): traversals.y = traversals.y.reverse();

	return traversals;


func get_main_node():
	var root = get_tree().get_root()
	return root.get_child(root.get_child_count() - 1)
