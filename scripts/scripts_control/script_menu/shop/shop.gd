extends Control

var card_data = GameData.card_data

@export var liste_generer = []
@export var liste_price = []
@export var liste_mult = [1,1,1,1,1,1]


func genere_card():
	liste_generer = []						# initialise les différentes listes
	liste_price = []
	var liste :Array = card_data.keys()		# La liste des noms des cards
	for i in range(6):
		liste_generer.append(liste[randi_range(0,len(liste)-1)])						# sélectionne une carte de façon aléatoire dans les cartes existente
		liste_price.append(randi_range(10,40)*liste_mult[i])									# génére un prix arbitraire (il faut changer les prix)
		print(i)
		create_card(liste_generer[i],liste_mult[i],i+1)											# crée la carte en fonction de la liste des carte généré, du nombre de carte et ça position 													
	print(liste_generer)
	return liste_generer
	
func create_card(card_name,number_card,position):
	position = "Card" + str(position)															# prend la position et la transforme en string avec "card_" devant, permet de selectionner la carte
	var card_icon = card_data[card_name]["texture"]									# initialise l'icon de la carte sur le node
	$GridContainer.get_node(position).get_node("card_button").number_card = int(position)-1
	print($GridContainer.get_node(position).get_node("card_button").number_card)
	$GridContainer.get_node(position).get_node("card_button").set_button_icon(load(card_icon))			# pose l'icon après l'initialise
	$GridContainer.get_node(position).get_node("card_label").text = card_data[card_name]["text"] + ' ' + str(liste_price[int(position)-1])			# met le text en dessous (str(liste[int(position)-1]) je n'ai pas trouvé autrement ;-;)
