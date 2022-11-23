extends Area2D

export var value: int

export var next_value: PackedScene

onready var move_tween := $Tween
onready var modulate_tween := $ModulateTween
onready var size_tween := $SizeTween
var piece_scale := Vector2(2.5, 2.5)
var piece_overscale := Vector2(3.75, 3.75)

func _ready() -> void:
	pop_in()

func pop_in():
	size_tween.interpolate_property(self, "scale", scale, piece_scale, 
	0.2, Tween.TRANS_SINE, Tween.EASE_OUT)
	size_tween.start()

func remove():
	size_tween.interpolate_property(self, "scale", scale, piece_overscale, 
	0.2, Tween.TRANS_SINE, Tween.EASE_OUT)
	modulate_tween.interpolate_property(self, "modulate", modulate, Color(0, 0, 0, 0), 
	0.2, Tween.TRANS_SINE, Tween.EASE_OUT)
	size_tween.start()
	modulate_tween.start()
	# queue_free()

func _on_ModulateTween_tween_completed(object: Object, key: NodePath) -> void:
	if scale == piece_overscale:
		queue_free()

func move(new_position: Vector2):
	move_tween.interpolate_property(self, "position", position,
	new_position, 0.3, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	move_tween.start()
## Declare member variables here. Examples:
## var a: int = 2
## var b: String = "text"
#var whosnext = ""
#var pos = position
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
#	EnemyData.connect("myturnasatile", self, "_on_Hero_myturn")
#
#func _on_Hero_myturn(unit):
#	for k in unit:
#		pos = unit[k]
#		whosnext = k
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	var t = delta * 7
#	var my_name = get_name()#get_parent().get_name()
#	if my_name == whosnext:#if "OPOS" in (my_name):
#		if whosnext in my_name.replace("OPOS", ""):
#			position = position.linear_interpolate(pos, t)
#			if position - pos <= Vector2(0.01, 0.01):
#				queue_free()
#
#onready var sp = $Sprite
#onready var tw = $Tween
#
#func add(num):
#	sp.frame = num
#	tw.interpolate_property(
#		sp,
#		"scale",
#		Vector2(0,0),
#		Vector2(1.1,1.1),
#		0.1,
#		Tween.TRANS_LINEAR,
#		Tween.EASE_IN_OUT
#	)
#	tw.start()
#	yield(tw, "tween_all_completed")
#	queue_free()
