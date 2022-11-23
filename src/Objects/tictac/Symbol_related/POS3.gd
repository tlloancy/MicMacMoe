extends CollisionShape2D
#
#
#
#
#onready var x = preload("res://src/Objects/Cross.tscn")
#onready var o = preload("res://src/Objects/Round.tscn")
#
#var selected = false
#export var pos = -1
#var store = "x or o"
#
#func play_x():
#	if(!selected and !PlayerData.win):
##		$x_o.set_texture(x)
##		$mouse_over.hide()
#		selected = true
#		PlayerData.pos = pos
#		PlayerData.store = "x"
#		#PlayerData.data_store[pos] = "x"
#		#PlayerData.check_win(pos, "x")
#
#
#
#func play_o(): 
#	if(!selected and !PlayerData.win):
##		$x_o.set_texture(o)
##		$mouse_over.hide()
#		selected = true
#		PlayerData.pos = pos
#		PlayerData.store = "o"
#		#PlayerData.data_store[pos] = "o"
#		#PlayerData.check_win(pos, "o")
#
##func _on_POS_input_event(viewport, event, shape_idx):
##	if(event is InputEventMouseButton and event.pressed):
##		if(event.button_index == BUTTON_LEFT):
##			play_x()
##			PlayerData.play_computer()
###		else:          #THIS IS FOR TESTING PURPOSES ONLY OR IF YOU WANT TO PLAY WITH 2 PLAYERS...
###			play_o()   #enable this for 2 player
