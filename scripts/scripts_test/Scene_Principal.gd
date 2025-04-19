extends Node3D

var number_wave = 0
var number_card = 0

var lenght_deck = 0.93*2
var wave_data = GameData.wave_data
var enemy_data = GameData.enemy_data
var array_card = []
var number_enemy = 0

@export var life = 50
@export var mana = 0
@export var piece = 50

func _ready() -> void:
	count_enemy()
	$HUD/Pass_wave.inter_wave(number_wave)

func _process(delta):
	if number_enemy == 0:
		piece += number_wave*10
		count_enemy()
		$HUD/Pass_wave.inter_wave(number_wave)
	if Input.is_action_just_pressed("start"):
		spawn_enemy()
	if Input.is_action_just_pressed("spawn_card_temp"):
		spawn_card("archer_card")
	if life <= 0:
		print("dead!")

func spawn_enemy():
	for i in wave_data[number_wave%len(wave_data)]:
		print(i)
		for j in range(i[1]):
			var new_enemy = load("res://scene/enemy_scene/" + i[0] +".tscn").instantiate()
			$node_environnement/map_test/Path.add_child(new_enemy, true)
			await (get_tree().create_timer(i[2],false)).timeout
	number_wave += 1
	

func count_enemy():
	for i in wave_data[number_wave%len(wave_data)]:
		number_enemy += i[1]


func spawn_card(name_card):
	name_card = "res://scene/card_scene/" + name_card + ".tscn"
	var new_card = load(name_card).instantiate()
	$node_environnement/map_test/movement_camera/camera/Camera3D.add_child(new_card, true)
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
				array_card[i].get_node("hitbox").position = Vector3(0,-0.44,-(len(array_card)-i)*0.01)
		else:
			for i in range(len(array_card)):
				array_card[i].position = Vector3(-(0.6*(compt - i)),-0.7,-0.9+i*0.01)
				array_card[i].get_node("hitbox").position = Vector3(0,-0.44,-(len(array_card)-i)*0.01)
	else:
		for i in range(len(array_card)):
			print(i)
			array_card[i].position = Vector3(-(0.93 - ((i*lenght_deck)/(len(array_card)-1))),-0.7,-0.9)
			array_card[i].get_node("hitbox").position = Vector3(0,-0.44,-(len(array_card)-i)*0.01)
			print(array_card[i].position)


func _on_test_turret_enemy_died() -> void:
	print("signal emit",number_enemy)
	number_enemy -= 1
