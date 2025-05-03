extends Button

@onready var number_card = 0

var card_data = GameData.card_data

func _on_pressed() -> void:

	var liste_buyed = $"../../../..".liste_buyed
	var liste_generer = $"../../..".liste_generer
	var liste_price = $"../../..".liste_price


	if liste_buyed[number_card]:
		liste_buyed[number_card] = 0
		$".."/card_label.text = card_data[liste_generer[number_card]]["text"] + ' ' + str(liste_price[number_card])
		$"../../../..".sum_price -= liste_price[number_card]
		$"../../.."/tot_price.text = str($"../../../..".sum_price)
		$".."/AnimationSelect.play("card_unselect")
		$".."/AnimationShake.stop()

	else:
		liste_buyed[number_card] = 1
		$".."/card_label.text = "buyed"
		$"../../../..".sum_price += liste_price[number_card]
		$"../../.."/tot_price.text = str($"../../../..".sum_price)
		$".."/AnimationSelect.play("card_select")
		$".."/AnimationShake.play("shake")

	print(liste_buyed)
