extends Area2D


func get_main_node():
	var root = get_tree().get_root()
	return root.get_child(root.get_child_count() - 1)
	
func dopple(body, scene, name):
	if not name in body.get_name().to_lower():
			print("droite instancié")
			var player = load(scene)#player2
			var player_instance = player.instance()
			player_instance.set_name(name)#player_dopple
			#get_node("Level15").add_child(player_instance)
			var LeftArea = get_main_node()#.get_node("Area2D") # effet sympa
			#LeftArea.call_deferred("add_child", player_instance)
			LeftArea.call_deferred("add_child", player_instance)
			#print(player_instance.position.x)
			#print(player_instance.position.y)
			#print(player_instance._velocity)
			#print (get_viewport().size.x)
			var largeur_decran = get_viewport().size.x
			player_instance.position.x = -largeur_decran + body.position.x 
			player_instance.position.y = body.position.y
			player_instance._velocity = body._velocity
			#print(player_instance.position.x)
			#print(player_instance.position.y)
			#print(player_instance._velocity)
			## bouclinfinie si peut sortit pzrotre cote sans etre kill
			#print("O")
			pass		

func picked(body) -> void:
	print("left")
	if "player" in body.get_name().to_lower():
		dopple(body, "res://src/Actors/Player2nocam.tscn", "player_dopple")
	elif "prayer" in body.get_name().to_lower():
		dopple(body, "res://src/Actors/Prayer.tscn", "prayer_dopple")

func _on_body_entered(body: Node) -> void:
	picked(body)


func _on_body_exited(body: Node) -> void:
	if "player" in body.get_name().to_lower():
		body.set_name("player_normal")
	elif "prayer" in body.get_name().to_lower():
		body.set_name("prayer_normal")
	pass # Replace with function body.
