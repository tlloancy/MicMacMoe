extends KinematicBody2D

#func _ready() -> void:
#	PlayerData.symbol_position = Vector2(0, 0)#position

#func get_direction() -> Vector2:
#	return Vector2(
#		PlayerData.symbol_position.x - PlayerData.previous_position.x,
#		PlayerData.symbol_position.y - PlayerData.previous_position.y
#	)
#
## https://docs.godotengine.org/en/stable/tutorials/math/interpolation.html
func _physics_process(delta: float) -> void:
	var t = delta * 10
	##position = PlayerData.symbol_position 
	## print(PlayerData.symbol_position)
#	move_and_slide(PlayerData.symbol_position, Vector2(0, 0), true)
	position = position.linear_interpolate(PlayerData.symbol_position, t)
	### transform.scaled(PlayerData.symbol_scale)
#	print (PlayerData.symbol_position)
#	var direction: = get_direction()
#	var is_jump_interrupted = false
#	var speed: = Vector2(300.0, 1000.0)
#	var gravity: = 0.0
#
#	var _velocity: = Vector2.ZERO
#	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
#	move_and_slide(_velocity)
#
#
#func calculate_move_velocity(
#	linear_velocity: Vector2,
#	direction: Vector2,
#	speed: Vector2,
#	is_jump_interrupted: bool
#	) -> Vector2:
#	var out: = linear_velocity
#	out.x = speed.x * direction.x
#	out.y = speed.y * direction.y
#	## out.y += gravity * get_physics_process_delta_time() # make the character move down delta
#	if direction.y == -1.0:
#		out.y = speed.y * direction.y # if stay _velocity no jump
#	if is_jump_interrupted:
#		out.y = 0.0
#	return out
#onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")
#
#export var score: = 100
#
#func _on_Coin_body_entered(body: Node) -> void:
#	picked()
#
#func picked() -> void:
#	PlayerData.score += score
#	anim_player.play("fade_out")
#










