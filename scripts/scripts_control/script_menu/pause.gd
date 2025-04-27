extends Control

@export_file("*.tscn") var menu = "res://scene/control/menu_test.tscn"


func pause():										# pour lancer le menu pause
	show()
	$menu.play("open_menu")
	get_tree().paused = true
	
func unpause():										# pour retirer le menu pause
	$menu.play("close_menu")
	get_tree().paused = false

func _process(delta):
	if Input.is_action_just_pressed("pause") and get_parent().get_node("death_menu").flag:				# condition pour lancer le menu pause avec la condition de la touche pause appuyé, vérifie si y'a pas déjà le menu de mort
		if get_tree().paused == false:																	# vérifie si ce n'est pas en pause, si c'est le cas mettre le menu pause, sinon l'enleve
			pause()
		else:
			unpause()
			
func _on_continue_pressed() -> void:
	unpause()

func _on_menu_pressed() -> void:

	get_tree().paused = false
	queue_free()
	get_tree().change_scene_to_file(menu)
	
