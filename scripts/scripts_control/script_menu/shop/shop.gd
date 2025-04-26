extends Control

var liste_card = GameData.card_data


@export var liste_generer = []
@export var liste_price = []
@export var liste_mult = [1,1,1,1,1,1]

func genere_card():
	liste_generer = []
	liste_price = []
	for i in range(6):
		liste_generer.append(liste_card[randi_range(0,len(liste_card)-1)])
		liste_price.append(randi_range(10,40)*liste_mult[i])
		print(i)
		create_card(liste_generer[i],1,i+1)
	print(liste_generer)
	return [liste_generer,liste_price]
	
func create_card(card_name,number_card,position):
	print(card_name)
	var container = (position + 1)/2
	container = "VBoxContainer" + str(container)
	position = "card_" + str(position)
	var card_icon = "res://image/" + card_name[0] +".png"
	$HBoxContainer.get_node(container).get_node(position).get_node(position + "_button").set_button_icon(load(card_icon))
	$HBoxContainer.get_node(container).get_node(position).get_node("card_label").text = card_name[1] + ' ' + str(liste_price[int(position)-1])
