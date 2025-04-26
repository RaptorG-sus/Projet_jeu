extends Control

var liste_card = GameData.card_data
@export var liste_generer = []
@export var liste_buyed = [0,0,0,0,0,0]
@export var liste_price = [0,0,0,0,0,0]

@onready var shop_node = $Shop

func shop_on():
	$animationWave.play("shop_go_up")

func shop_down():
	$animationWave.play("shop_go_down")

func wave_up():
	$animationWave.play("wave_go_up")

func wave_down():
	$animationWave.play("wave_go_down")

func inter_wave(number_wave):
	$show_wave/wave_label.text = "wave " + str(number_wave+1)
	wave_up()
	await (get_tree().create_timer(3,false)).timeout
	wave_down()
	#if marchand alors :
	await (get_tree().create_timer(0.7,false)).timeout
	shop_on()
	var retour_genere_card = shop_node.genere_card()
	liste_generer = retour_genere_card[0]
	liste_price = retour_genere_card[1]


func _on_pass_wave_pressed() -> void:
	shop_down()
	print(liste_generer)
	for i in range(len(liste_buyed)):
		if liste_buyed[i]:
			get_parent().get_parent().spawn_card(liste_generer[i][0])
			get_parent().get_parent().piece -= liste_price[i]
	liste_buyed = [0,0,0,0,0,0]
	await (get_tree().create_timer(3, false)).timeout
	$"../..".spawn_enemy()
			
