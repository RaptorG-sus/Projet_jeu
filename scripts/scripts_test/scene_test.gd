extends Node3D

var number_wave = 0
var number_card = 0

var lenght_deck = 0.93*2
var wave_data = GameData.wave_data
var enemy_data = GameData.enemy_data
var array_card = []

@export var life = 50

func _process(delta):
	if Input.is_action_just_pressed("start"):
		spawn_enemy()
		if len(wave_data) != number_wave + 1:
			number_wave += 1
	if Input.is_action_just_pressed("spawn_card_temp"):
		spawn_card()
		
	if life <= 0:
		print("dead!")

func spawn_enemy():
	for i in wave_data[number_wave]:
		print(i)
		for j in range(i[1]):
			var new_enemy = load("res://scene/enemy_scene/" + i[0] +".tscn").instantiate()
			$map_test/Path.add_child(new_enemy, true)
			await (get_tree().create_timer(i[2])).timeout

func spawn_card():
	var new_card = load("res://scene/card_scene/archer_card.tscn").instantiate()
	$map_test/movement_camera/camera/Camera3D.add_child(new_card, true)
	array_card.append(new_card)
	new_card.scale = Vector3(0.5,0.5,0.5)
	new_card.position = Vector3(0, -0.7, -0.9)
	decal_card()
	for i in range(len(array_card)):
		array_card[i].get_node("card").render_priority = len(array_card) - i
		

func decal_card():
	if len(array_card) < 5:
		var compt = len(array_card) / 2
		if len(array_card)%2 == 0:
			compt -= 1
			for i in range(len(array_card)):
				print(i,compt)
				array_card[i].position = Vector3(-(0.3+0.6*(compt - i)),-0.7,-0.9+i*0.01)
		else:
			for i in range(len(array_card)):
				array_card[i].position = Vector3(-(0.6*(compt - i)),-0.7,-0.9+i*0.01)
	else:
		for i in range(len(array_card)):
			print(i)
			array_card[i].position = Vector3(-(0.93 - ((i*lenght_deck)/(len(array_card)-1))),-0.7,-0.9)
			array_card[i].get_node("hitbox").position = Vector3(0,-0.54,(len(array_card)-i)*0.01)
			print(array_card[i].position)

						  
