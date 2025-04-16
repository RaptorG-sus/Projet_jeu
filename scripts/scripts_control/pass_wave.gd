extends Control

var liste_card = GameData.card_data
var liste_generer = []

func shop_on():
	$animationWave.play("shop_go_up")

func shop_down():
	$animationWave.play("shop_go_down")

func wave_up():
	$animationWave.play("wave_go_up")

func wave_down():
	$animationWave.play("wave_go_down")

func inter_wave(number_wave):
	$show_wave/wave_label.text = "wave " + str(number_wave)
	wave_up()
	await (get_tree().create_timer(3,false)).timeout
	wave_down()
	#if marchant alors :
	await (get_tree().create_timer(0.7,false)).timeout
	shop_on()
	genere_card()

func genere_card():
	liste_generer = []
	for i in range(6):
		liste_generer.append(liste_card[randi_range(0,len(liste_card)-1)])
		print(i)
		create_card(liste_generer[i],1,i+1)
	print(liste_generer)
	
func create_card(card_name,number_card,position):
	print(card_name)
	var container = (position + 1)/2
	container = "VBoxContainer" + str(container)
	position = "card_" + str(position)
	
	var card_icon = "res://image/" + card_name[0] +".png"
	$Shop/HBoxContainer.get_node(container).get_node(position).get_node(position + "_button").set_button_icon(load(card_icon))
	$Shop/HBoxContainer.get_node(container).get_node(position).get_node("card_label").text = card_name[1]

func _on_pass_wave_pressed() -> void:
	shop_down()

func _on_card_1_button_pressed() -> void:
	$"../..".spawn_card(liste_generer[0][0])

func _on_card_2_button_pressed() -> void:
	$"../..".spawn_card(liste_generer[1][0])

func _on_card_3_button_pressed() -> void:
	$"../..".spawn_card(liste_generer[2][0])

func _on_card_4_button_pressed() -> void:
	$"../..".spawn_card(liste_generer[3][0])

func _on_card_5_button_pressed() -> void:
	$"../..".spawn_card(liste_generer[4][0])

func _on_card_6_button_pressed() -> void:
	$"../..".spawn_card(liste_generer[5][0])
