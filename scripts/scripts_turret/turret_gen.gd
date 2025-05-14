extends Area3D

var projectile :PackedScene = preload("res://scene/props/projectile.tscn")
var turret_data = GameData.turret_data["turret_test"]["base"]
var flag_menu_upgrade = false

var attack_speed = turret_data["attack_speed"]
var range_turret = turret_data["range"]
var damage = turret_data["damage"]
var pierce = turret_data["pierce"]
var bullet_speed = turret_data["bullet_speed"]

@onready var current_enemy = null
var liste_enemy = []

func _ready() -> void:
	$".".input_ray_pickable = false
	$Timer.set_wait_time(attack_speed)
	$CollisionShape3D.shape.set_radius(range_turret)

func _process(delta: float) -> void:
	if len(liste_enemy) != 0:
		look_at(liste_enemy[0].global_position)
	else:
		smooth_rotation()
	
	if $Timer.wait_time != attack_speed:
		$Timer.set_wait_time(attack_speed)
	
	if $CollisionShape3D.shape.get_radius() != range_turret:
		$CollisionShape3D.shape.set_radius(range_turret)
		
		
func smooth_rotation() -> void:
	var r = Vector3.ZERO
	var ratio = 0.1
	var rotation_need = rotation
	
	if rotation != r:
		rotation -= rotation_need*ratio

# gestion création de projectiles vers l'ennemis
#_______________________________________________________________________________________________________________________________
func _on_timer_timeout() -> void:
	var p = projectile.instantiate()

	$"../../.."/Projectiles.add_child(p)
	p.global_position = global_position
	p.enemy_pos = liste_enemy[0].global_position
	p.parent_pos = global_position
	p.damage = damage
	p.pierce = pierce
	p.speed = bullet_speed

#gestion détection enemies
#_______________________________________________________________________________________________________________________________
func _on_area_entered(area: Area3D) -> void:
	liste_enemy.append(area)
	if len(liste_enemy) == 1:
		$Timer.start()

func _on_area_exited(area: Area3D) -> void:
	liste_enemy.erase(area)
	if len(liste_enemy) == 0:
		$Timer.stop()


# gestion souris pour amélioration
#_______________________________________________________________________________________________________________________________
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and flag_menu_upgrade and get_viewport().get_mouse_position().x > $"../upgradePannel"/panel_upgrade.size.x:
		print(get_viewport().get_mouse_position().y)
		flag_menu_upgrade = false
		$".."/upgradePannel.close_menu()
		print(name)

func _on_hit_box_joueur_input_event(camera:Node, event:InputEvent, event_position:Vector3, normal:Vector3, shape_idx:int) -> void:
	if event is InputEventMouseButton and event.pressed and flag_menu_upgrade == false:
		flag_menu_upgrade = true
		$".."/upgradePannel.show_menu()
