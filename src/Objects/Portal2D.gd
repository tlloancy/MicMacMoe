#tool # pour alert apparaisse
extends Area2D

onready var anim_player: AnimationPlayer = $AnimationPlayer


export var next_scene: PackedScene
export (String, FILE) var previous_scene# bug
#export var previous_scene: PackedScene

func _on_body_entered(body: Node) -> void:
	teleport()

func _get_configuration_warning() -> String:
	return "The next scene property can't be empty" if not next_scene else ""
	
func teleport() -> void:
		PlayerData.win = false
		anim_player.play("fade_in")
		yield(anim_player, "animation_finished")
		get_tree().change_scene_to(next_scene)

var sun
var moon
func _ready() -> void:
	sun = get_main_node().get_node("CanvasLayer/ParallaxBackground/ParallaxLayer/Fichier 9")
	moon = get_main_node().get_node("CanvasLayer/ParallaxBackground/ParallaxLayer/Fichier 10")
	PlayerData.connect("we_have_win", self, "sun")
	PlayerData.connect("we_have_draw", self, "moon")
	
func sun() -> void:
	owait(2, "teleport")

func teleport_two() -> void:
	PlayerData.trapped_for_good = 0
	anim_player.play("fade_in")
	yield(anim_player, "animation_finished")
	get_tree().change_scene_to(load(previous_scene))

func moon() -> void:
	owait(3, "teleport_two")
	#teleport_two()
#var timing = 0
func _physics_process(delta: float) -> void:
	#timing += delta
	#if timing >= 1.0:
		if PlayerData.win or PlayerData.winmill:
			var t = delta * 2
			sun.position = sun.position.linear_interpolate(PlayerData.symbol_position, t)
		elif PlayerData.trapped_for_good == 1:
			var t = delta * 2
			var v = 2500
			moon.position = moon.position\
			.linear_interpolate(Vector2(sun.position.x-v, sun.position.y-v), t)
			sun.position = sun.position.linear_interpolate(Vector2(v*2,v*2),t/10)
	#	timing = 0
	
func get_main_node():
	var root = get_tree().get_root()
	return root.get_child(root.get_child_count() - 1)

func owait(tim, callwo):
	#yield(get_tree().create_timer(tim), "timeout")


	# Create a timer node
	var timer = Timer.new()

	# Set timer interval
	timer.set_wait_time(tim) #(1.0)

	# Set it as repeat
	timer.set_one_shot(false)

	# Connect its timeout signal to the function you want to repeat
	timer.connect("timeout", self, callwo)

	# Add to the tree as child of the current node
	add_child(timer)

	timer.start()


func repeat_me():
	print("Loop")
#signal timer_end

#func _wait( seconds ):
#	self._create_timer(self, seconds, true, "_emit_timer_end_signal")
#	yield(self,"timer_end")

#func _emit_timer_end_signal():
#	emit_signal("timer_end")

#func _create_timer(object_target, float_wait_time, bool_is_oneshot, string_function):
#	var timer = Timer.new()
#	timer.set_one_shot(bool_is_oneshot)
#	timer.set_timer_process_mode(0)
#	timer.set_wait_time(float_wait_time)
#	timer.connect("timeout", object_target, string_function)
#	self.add_child(timer)
#	timer.start()
