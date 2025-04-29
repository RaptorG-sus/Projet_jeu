extends Button

func _on_pressed() -> void:

	var liste_buyed = $"../../../../..".liste_buyed
	var liste_generer = $"../../../..".liste_generer
	var liste_price = $"../../../..".liste_price


	if liste_buyed[int(name)-1]:
		liste_buyed[int(name)-1] = 0
		$".."/card_label.text = liste_generer[int(name)-1] + ' ' + str(liste_price[int(name)-1])
		$"../../../../..".sum_price -= liste_price[int(name)-1]
		$"../../../.."/tot_price.text = str($"../../../../..".sum_price)
	else:
		liste_buyed[int(name)-1] = 1
		$".."/card_label.text = "buyed"
		$"../../../../..".sum_price += liste_price[int(name)-1]
		$"../../../.."/tot_price.text = str($"../../../../..".sum_price)
	print(liste_buyed)
