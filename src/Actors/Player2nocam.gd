extends Actor

export var stomp_impulse: = 1000.0
onready var onright_its = preload("res://assets/nocounturn2.png")
onready var onleft_its = preload("res://assets/cntur.png")
onready var oncnter_its = preload("res://assets/nocounturn.png")
onready var onbas_its = preload("res://assets/lookdown.png")
onready var alien_sprite = get_node("player")

func mirrorbros2(_velocity):
	if _velocity.x > 0:
		alien_sprite.set_texture(onright_its)
	elif _velocity.x < 0:
		alien_sprite.set_texture(onleft_its)
	elif Input.is_action_pressed("move_down"):
		alien_sprite.set_texture(onbas_its)
	else:
		alien_sprite.set_texture(oncnter_its)
	#if self.position.x <= 0: 
	#	print(self.position)#self.position.x = get_viewport().size.x 
	#if self.position.x >= get_viewport().size.x: 
	#	print(self.position)#self.position.x = 0

func _on_EnemyDetector_area_entered(area: Area2D) -> void:
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)



func _on_EnemyDetector_body_entered(body: Node) -> void:
	die()

# you modify high jump with speed
func _physics_process(delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0 # negative _velocity goes up
	
	var direction: = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted) # speed * direction
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL) # in parent class fall slowly # 2nd parameter floor normal
	mirrorbros2(_velocity)

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right")		- Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0 # 1.0 fall and stays on the ground # 0.0 stays same level
	)
	
func calculate_move_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2,
	is_jump_interrupted: bool
	) -> Vector2:
	var out: = linear_velocity
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time() # make the character move down delta
	if direction.y == -1.0:
		out.y = speed.y * direction.y # if stay _velocity no jump
	if is_jump_interrupted:
		out.y = 0.0
	return out

func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	var  out: = linear_velocity
	out.y = -impulse
	return out

func die() -> void:
	PlayerData.deaths += 1
	queue_free()



func _on_VisibilityNotifier2D_viewport_entered(viewport: Viewport) -> void:
	print("entertrigger")
	print(get_viewport().size.x)
	print(self.position)
	pass # Replace with function body.
	
	


func _on_VisibilityNotifier2D_viewport_exited(viewport: Viewport) -> void:
	print("exittrigger")
	print(self.position)
	pass # Replace with function body.


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
	print("s")
	print(self.position)
	pass # Replace with function body.
