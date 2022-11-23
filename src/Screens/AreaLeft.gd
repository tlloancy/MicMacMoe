extends Area2D

#onready var RightArea: Area2D = get_node("Area2D2")
	
func get_main_node():
	var root = get_tree().get_root()
	return root.get_child(root.get_child_count() - 1)	

func dopple(body, scene, name):
	print(body.get_name())
	if not name in body.get_name().to_lower(): #au lieu de byd.get_name != name
			print("gauche instancié") # boucle infinie bug de cote
			var player = load(scene) # je sais aps pk
			var player_instance = player.instance()
			player_instance.set_name(name)
			#get_node("Level15").add_child(player_instance)
			var RightArea = get_main_node()#.get_node("Area2D2")
			RightArea.call_deferred("add_child", player_instance)
			var largeur_decran = get_viewport().size.x
			player_instance.position.x = largeur_decran + body.position.x 
			player_instance.position.y = body.position.y
			player_instance._velocity = body._velocity
func picked(body) -> void:
	print("left")
	if "player" in body.get_name().to_lower():
			dopple(body, "res://src/Actors/Player2nocam.tscn", "player_dopple")	
			#player_instance.position.y = body.get_position().y
			pass
	elif "prayer" in body.get_name().to_lower():
			dopple(body, "res://src/Actors/Prayer.tscn", "prayer_dopple")
			#var player = load("res://src/Actors/Prayer.tscn")
			#var player_instance = player.instance()
			#player_instance.set_name("prayer_dopple")
			#get_node("Level15").add_child(player_instance)
			#var RightArea = get_main_node().get_node("Area2D2")
			#RightArea.call_deferred("add_child", player_instance)
			#pass	

# je sais que screen exited n aura pas quitte l area
## donc je peux dire que on area exited sera forcement 
## le fait de l entree du cube dans la scene visible
func _on_body_entered(body: Node) -> void:
	picked(body)


func _on_body_exited(body: Node) -> void:
	print("wtf")
	print(body.get_name())
	if "player" in body.get_name().to_lower():
		body.set_name("player_normal")
	elif "prayer" in body.get_name().to_lower():
		body.set_name("prayer_normal")	
	pass # Replace with function body.
