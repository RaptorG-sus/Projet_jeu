extends Control

var liste_card = GameData.card_data
@export var liste_generer = []
@export var liste_buyed = [0,0,0,0,0,0]
@export var liste_price = [0,0,0,0,0,0]
@export var sum_price = 0
@onready var shop_node = $Shop

# toute les animations pour les événements entre les vagues
func shop_on():
	$animationWave.play("shop_go_up")

func shop_down():
	$animationWave.play("shop_go_down")

func wave_up():
	$animationWave.play("wave_go_up")

func wave_down():
	$animationWave.play("wave_go_down")

# à modifié : fonction qui fait le déroulement entre les vagues
func inter_wave(number_wave):
	sum_price = 0
	$show_wave/wave_label.text = "wave " + str(number_wave+1)
	wave_up()
	await (get_tree().create_timer(3,false)).timeout
	wave_down()
	#if marchand alors :
	await (get_tree().create_timer(0.7,false)).timeout
	shop_on()
	$Shop/tot_price.text = str(sum_price)
	liste_generer = shop_node.genere_card()

# bouton pour passer à la vague suivante
func _on_pass_wave_pressed() -> void:
	print(sum_price)
	if sum_price > $"../..".piece:		# vérifie si le total est supérieur au nombre de pièce dans l'inventaire
		print("trop cher")				# à modifier : il faudrait rajouter un effet d'écran / bruitages
	else:
		shop_down()						# lance l'animation pour réduire le shop	
		print(liste_generer)
		for i in range(len(liste_buyed)):		# boucle pour générer les cartes dans le deck
			if liste_buyed[i]:						# vérifie si la carte est acheté, si oui génére la carte dans le deck
				get_parent().get_parent().spawn_card(liste_generer[i][0])				# appel de la fonction pour générer la carte avec la carte voulue 
		get_parent().get_parent().piece -= sum_price						# retire le prix total des cartes des pièces
		liste_buyed = [0,0,0,0,0,0]								# remet à 0 les vérifications 
		await (get_tree().create_timer(3, false)).timeout		# lance un timer pour attendre 3 seconde
		$"../..".spawn_enemy()				# lance la prochaine vague
				
