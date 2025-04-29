extends Node3D

var number_wave = 0
var number_card = 0

var lenght_deck = 0.93*2
var wave_data = GameData.wave_data
var enemy_data = GameData.enemy_data
var array_card = []

@export var number_enemy = 0
@export var life = 50
@export var mana = 0
@export var piece = 50

func _ready() -> void:
	count_enemy()					# permet d'avoir le nombre d'enemy afin de vérifier si il en reste sur le terrain ou non, si non alors déclencher le pass wave pour passer à la vagues suivante automatiquement, il faut faire le count enemy avant de déclencher interwave
	$HUD/Pass_wave.inter_wave(number_wave)			# fonction interwave dans le HUD/Pass_wave

func _process(delta):
	if number_enemy == 0:					# vérifie si il n'y a plus d'enemy sur la map, auquel cas il recompte le nombre d'enemy de la vague suivante et déclenche la fonction interwave
		piece += number_wave*10
		count_enemy()
		$HUD/Pass_wave.inter_wave(number_wave)
	
	if Input.is_action_just_pressed("start"):				# fonction débug pour spawn une vague d'enemy
		spawn_enemy()
	
	if Input.is_action_just_pressed("spawn_card_temp"):				# fonction début pour spawn un card dans le deck (carte archer)
		spawn_card("archer_card")



func spawn_enemy():													# fonction pour faire spawn une vague, vague crée non aléatoirement dans le singleton GameData
	for i in wave_data[number_wave%len(wave_data)]:						# lis tous les enemy de la x vague
		print(i)
		for j in range(i[1]):											# permet de faire spawn x enemy écrit dans la liste d'enemy
			var new_enemy = load("res://scene/enemy_scene/" + i[0] +".tscn").instantiate()			# instentie l'enemy
			$node_environnement/map_test/Path.add_child(new_enemy, true)							# créer l'enemy
			await (get_tree().create_timer(i[2],false)).timeout										# créer un timer avec x temps écrit dans la liste expilicant l'enemy
	number_wave += 1					# incrémente le nombre de vague
	

func count_enemy():
	for i in wave_data[number_wave%len(wave_data)]:
		number_enemy += i[1] 


func spawn_card(name_card):
	name_card = "res://scene/card_scene/" + name_card + ".tscn"			# prend la scene de la carte sélectionné avec name_card
	var new_card = load(name_card).instantiate()						# instantie la carte
	$node_environnement/map_test/movement_camera/camera/Camera3D.add_child(new_card, true)			# créer la carte dans le deck
	array_card.append(new_card)							# met la carte dans une liste
	new_card.scale = Vector3(0.5,0.5,0.5)				# change les mesure des cartes
	new_card.position = Vector3(0, -0.7, -0.9)
	decal_card()
	for i in range(len(array_card)):
		array_card[i].get_node("card").render_priority = len(array_card) - i		
		

func decal_card():
	if len(array_card) < 5:					# vérification si inférieur à 5
		var compt = len(array_card) / 2			# divise par deux la longueur de la liste carte
		if len(array_card)%2 == 0:					# vérifie si c'est le nombre de carte est pari ou impair
			compt -= 1
			for i in range(len(array_card)):		# boucle de la longueur du nmobre de carte
				print(i,compt)
				array_card[i].position = Vector3(-(0.3+0.6*(compt - i)),-0.7,-0.9+i*0.01)			# positionne la carte en fonction de ça position de la liste
				array_card[i].get_node("hitbox").position = Vector3(0,-0.44,-(len(array_card)-i)*0.01)	# positionne ça hitbox
		else:																						# similaire mais avec des coordonnées différentes pour les liste impair
			for i in range(len(array_card)):
				array_card[i].position = Vector3(-(0.6*(compt - i)),-0.7,-0.9+i*0.01)
				array_card[i].get_node("hitbox").position = Vector3(0,-0.44,-(len(array_card)-i)*0.01)
	else:								# si il y a plus de 5 carte alors l'espacement est automatique, donc similaire au précédent mais avec une distance calculé par rapport à son nombre
		for i in range(len(array_card)):
			print(i)
			array_card[i].position = Vector3(-(0.93 - ((i*lenght_deck)/(len(array_card)-1))),-0.7,-0.9)
			array_card[i].get_node("hitbox").position = Vector3(0,-0.44,-(len(array_card)-i)*0.01)
			print(array_card[i].position)


func _on_enemy_died() -> void:
	print("signal emit",number_enemy)
	number_enemy -= 1
