extends Actor

var crosses = []
var rounds = []
var jump = false
var PADDING_OBJECT_PATH = 500
var ev
export var stomp_impulse: = 1000.0 + 700
onready	var whereami = get_tree().get_current_scene().get_name()

export var twopiece: PackedScene
export var fourpiece: PackedScene

func get_main_node():
	var root = get_tree().get_root()
	return root.get_child(root.get_child_count() - 1)

func _ready() -> void:
	speed = Vector2(500, 1300)##speed.x *= 0.7
	set_physics_process(false) # deactivate the enemy at the start of the game # cocher visibiliteenable pareil
	if _velocity == Vector2.ZERO:
		_velocity.x = -speed.x # si il bouge deja on le laisse
	if whereami == "Level20":
		var ia = load("res://src/Ai/ia_duemil.tscn")
		var ia_instance = ia.instance()
		#ia_instance.set_name("ia_duemil")
		add_child(ia_instance)
		####grid_reset_men()
		ev = InputEventAction.new()
		ev.pressed = false

func _on_EnemyDetector_area_entered(area: Area2D) -> void:
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)
	
func list_files_in_directory(path):
	var files = []
#	var dir = Directory.new()
#	dir.open(path)
#	dir.list_dir_begin()
#
	files = path.get_children()
#	while true:
#		var file = dir.get_next()
#		if file == "":
#			break
#		elif not file.begins_with("."):
#			files.append(get_main_node().get_node(file))
#
	#dir.list_dir_end()

	return files

func count_crosses_and_rounds():
	var nodes_r = list_files_in_directory(get_main_node().get_node("Rounds"))
	var nodes_c = list_files_in_directory(get_main_node().get_node("Crosses"))
	#print("hohe")
	for r in nodes_r:
		#print(r)
		#print(r.position)
		rounds.append(r)
	for c in nodes_c:
		#print(c.position)
		rounds.append(c)

func target_attk():
	var best_target = null

	for target in rounds:
		var wr = weakref(target)
		if not wr.get_ref():
			continue
		if not target or target.hooked:
			continue
		if best_target == null:
			best_target = target
		elif target.position - position < best_target.position - position:
			best_target = target

	return best_target

func follow_her(target, _velocity):
	if target.position.x < position.x - PADDING_OBJECT_PATH:
		if _velocity.x > 0:
			_velocity.x *= -1
	elif target.position.x > position.x + PADDING_OBJECT_PATH:
		if _velocity.x < 0:
			_velocity.x *= -1
	if target.position.y < position.y and is_on_floor():
		jump = true
	else: jump = false
	return _velocity

func tictacgame(_velocity, delta):
	count_crosses_and_rounds()
	var target = target_attk()
	_velocity = follow_her(target, _velocity)
	return _velocity
	pass
	
func follow_the_leader(dir, _velocity):
	jump = false
	if dir == 1: # on va a droite
		_velocity = Vector2(1, 0)
	elif dir == -1: # on va a gauche
		_velocity = Vector2(-1, 0)
	elif dir == 4: # on va en bas
		_velocity = Vector2(0, 0)
	elif dir == -4: # on va en haut
		_velocity = Vector2(0, 0)
		jump = true
	return _velocity
	
func deuxmilgame(_velocity, delta):
	var res = []
	res.resize(1)
	#https://github.com/rajlakshmide/Game-of-2048/blob/master/PlayerAI_3.py
	var reflexion = get_node("ia_duemil")
	reflexion.letsgo(delta, res)
	var dir = res[0]
	_velocity = follow_the_leader(dir, _velocity)
	return _velocity
	pass

#func _on_EnemyDetector_body_entered(body: Node) -> void:
#	die()

# you modify high jump with speed
func _physics_process(delta: float) -> void:
	###_velocity.y += gravity * delta # sut terre
	# is on wall only update if you move your enemy
	if is_on_wall():
		_velocity.x *= -1.0 # else 1 apprently ligne du dessus a disparu
	var direction: = get_direction(_velocity)
	_velocity = calculate_move_velocity(_velocity, direction, speed, false)
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y # only reset y so enemy can change dir
	if whereami == "Level19":
		_velocity = tictacgame(_velocity, delta)
	elif whereami == "Level20":
		_velocity = deuxmilgame(_velocity, delta)
func get_direction(_velocity) -> Vector2:
	var ok = 0
	if _velocity.x < 0:
		ok = -1
	elif _velocity.x > 0:
		ok = 1
	return Vector2(
		ok,
		-1 if jump else 1
	)
	
func calculate_move_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2,
	is_jump_interrupted: bool
	) -> Vector2:
	var out: = linear_velocity
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		out.y = speed.y * direction.y
	if is_jump_interrupted:
		out.y = 0.0
	return out

func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	var  out: = linear_velocity
	out.y = -impulse
	return out

#func die() -> void:
#	EnemyData.deaths += 1
#	queue_free()



func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
	pass # Replace with function body.
	
func simulate_key(key) -> void:
# Set as move_left, pressed.
	ev.action = key
	ev.pressed = true
	if not "down" in key:
		ev.pressed = true
	#ev.pressed = false

