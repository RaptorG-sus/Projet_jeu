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

	if draggingCollider:
		draggingCollider.global_position = mousePosition


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
# recupere et instantie la scene generale des card
	var new_card = load("res://scene/card_scene/base_card.tscn").instantiate()
	new_card.card_name = name_card
	var container = $HUD/deck/HBoxContainer
	container.add_child(new_card, true)			# créer la carte dans le deck
	new_card.mouse_in.connect(_on_mouse_in)
		
	array_card.append(new_card)							# met la carte dans une liste


func _on_enemy_died() -> void:
	print("signal emit",number_enemy)
	number_enemy -= 1
	
	
	
	
	
	
	# code for the drag & drop

var draggingCollider
var mousePosition
var doDrag = false
	
	
	
func _on_mouse_in(vector:Vector2, click:bool, button_statment:bool):
		
	var intersect
	
	intersect = get_mouse_intersect(vector)
	if intersect: mousePosition = intersect.position 
	#snap on collider
	#if intersect: mousePosition = intersect.collider.global_position
	print(intersect)
	if click && intersect:

		if button_statment:
			doDrag = true
			drag_and_drop(intersect)
		elif !button_statment:
			doDrag = false
			drag_and_drop(intersect)



func drag_and_drop(intersect):
	if !draggingCollider && doDrag:
		draggingCollider = intersect.collider
		draggingCollider.set_collision_layer(false)
	elif draggingCollider:
		draggingCollider.set_collision_layer(true)
		draggingCollider = null
	
	
func get_mouse_intersect(mousePosition):
	var currentCamera = get_viewport().get_camera_3d()
	var params = PhysicsRayQueryParameters3D.new()
	
	params.from = currentCamera.project_ray_origin(mousePosition)
	params.to = currentCamera.project_position(mousePosition, 1000)
	if draggingCollider: params.exclude = [draggingCollider]
	
	var worldspace = get_world_3d().direct_space_state
	var result = worldspace.intersect_ray(params)
	
	if result:
		var normal = result.normal
		# CONDITION sur l'angle 
		return result
		
	return null
