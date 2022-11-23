extends "res://src/Actors/Actor.gd"
# onready var stomp_area: Area2D = $StompArea2D
export var score: = 100

func _ready() -> void:
	set_physics_process(false) # deactivate the enemy at the start of the game # cocher visibiliteenable pareil
	_velocity.x = -speed.x



func _on_StompDetector_body_entered(body: Node) -> void:
	if body.global_position.y >  get_node("StompDetector").global_position.y:
		return
	# get_node("CollisionShape2D").disabled = true # get_node ou $ CollisionShape2D
	get_node("CollisionShape2D").set_deferred("disabled", true)
	# body_set_shape_disabled cant change this state while flushing queries. use defer to change monitoring instead
	die()

func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta # sut terre
	# is on wall only update if you move your enemy
	if is_on_wall():
		_velocity.x *= -1.0 # else 1 apprently ligne du dessus a disparu
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y # only reset y so enemy can change direction

func die() -> void:
	queue_free()
	PlayerData.score += score
