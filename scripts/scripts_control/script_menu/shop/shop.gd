extends Control

var card_data = GameData.card_data

@export var liste_generer = []
@export var liste_price = []
@export var liste_mult = [1,1,1,1,1,1]
var liste_card_out = []
var flag_liste_card_out_pass

var card_obtain = load("res://scene/card_scene/card_obtain.tscn")

var acc_card = 0

func genere_card():
	liste_generer = []						# initialise les différentes listes
	liste_price = []
	flag_liste_card_out_pass = false
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


func card_placement_shop(card_icon,pos):
	var card_out = card_obtain.instantiate()
	$card_obtain_dir.add_child(card_out)
	liste_card_out.append([pos,card_out])
	card_out.get_child(0).texture = card_icon
	card_out.position.y = card_out.position.y + acc_card*30
	acc_card += 1 


func card_unplacement_shop(pos):
	var erase_liste_element
	for i in liste_card_out:
		if i[0] == pos:
			i[1].queue_free()
			flag_liste_card_out_pass = true
			acc_card -= 1
			erase_liste_element = i
		else:
			if flag_liste_card_out_pass:
				i[1].position.y -= 30
	liste_card_out.erase(erase_liste_element)
	flag_liste_card_out_pass = false
			
