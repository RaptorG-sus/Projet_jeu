extends Control

var liste_card = GameData.card_data


@export var liste_generer = []
@export var liste_price = []
@export var liste_mult = [1,1,1,1,1,1]


func genere_card():
	liste_generer = []						# initialise les différentes listes
	liste_price = []
	for i in range(6):
		liste_generer.append(liste_card[randi_range(0,len(liste_card)-1)])						# sélectionne une carte de façon aléatoire dans les cartes existente
		liste_price.append(randi_range(10,40)*liste_mult[i])									# génére un prix arbitraire (il faut changer les prix)
		print(i)
		create_card(liste_generer[i],liste_mult[i],i+1)											# crée la carte en fonction de la liste des carte généré, du nombre de carte et ça position 													
	print(liste_generer)
	return liste_generer
	
func create_card(card_name,number_card,position):
	print(card_name)
	var container = (position + 1)/2															# container pour sélectionner le vertical container
	container = "VBoxContainer" + str(container)												# pour créer le str qui selectionnera le dit container
	position = "card_" + str(position)															# prend la position et la transforme en string avec "card_" devant, permet de selectionner la carte
	var card_icon = "res://image/" + card_name[0] +".png"										# initialise l'icon de la carte sur le node
	$HBoxContainer.get_node(container).get_node(position).get_node(position + "_button").set_button_icon(load(card_icon))			# pose l'icon après l'initialise
	$HBoxContainer.get_node(container).get_node(position).get_node("card_label").text = card_name[1] + ' ' + str(liste_price[int(position)-1])			# met le text en dessous (str(liste[int(position)-1]) je n'ai pas trouvé autrement ;-;)
