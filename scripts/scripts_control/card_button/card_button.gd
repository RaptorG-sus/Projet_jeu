extends Button

func _on_pressed() -> void:
	var liste_buyed = get_parent().get_parent().get_parent().get_parent().get_parent().liste_buyed
	var liste_generer = get_parent().get_parent().get_parent().get_parent().get_parent().liste_generer
	if liste_buyed[int(name)-1]:
		liste_buyed[int(name)-1] = 0
		$".."/card_label.text = liste_generer[int(name)-1][1]
	else:
		liste_buyed[int(name)-1] = 1
		$".."/card_label.text = "buyed"
	print(liste_buyed)
