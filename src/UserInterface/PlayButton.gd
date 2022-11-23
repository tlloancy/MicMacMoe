tool # run any code inside of the editor -- crate plugin for example
extends Button

export(String, FILE) var next_scene_path: = ""

func _on_button_up() -> void: # on this node attached script already so no more complicated name
	get_tree().paused = false # si on revient des morts c bloqué
	get_tree().change_scene(next_scene_path)

func _get_configuration_warning() -> String:
	return "next_scene_path must be set for the button to work"  if next_scene_path == "" else ""
