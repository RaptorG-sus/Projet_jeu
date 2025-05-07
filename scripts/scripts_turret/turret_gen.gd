extends Area3D

var projectile :PackedScene = preload("res://scene/props/projectile.tscn")
var turret_data = GameData.turret_data

var flag_menu_upgrade = false
var flag_current_animation = true
var flag_animation_playing = false
#var turret_name = str(get_parent().name)

var attack_speed = turret_data["villager"]["base"]["attack_speed"]
var range_turret = turret_data["villager"]["base"]["range"]
var damage = turret_data["villager"]["base"]["damage"]
var pierce = turret_data["villager"]["base"]["pierce"]
var bullet_speed = turret_data["villager"]["base"]["bullet_speed"]

signal throw

@onready var current_enemy = null
var liste_enemy = []

func _ready() -> void:
	rotate_y(180)
	$".".input_ray_pickable = false
	$Timer.set_wait_time(attack_speed)
	$CollisionShape3D.shape.set_radius(range_turret)

func _process(delta: float) -> void:
	if len(liste_enemy) != 0:
		look_at(liste_enemy[0].global_position)
		rotation.x = 0
		rotation.z = 0
	else:
		smooth_rotation()
	
	if $Timer.wait_time != attack_speed:
		$Timer.set_wait_time(attack_speed)
	
	if $CollisionShape3D.shape.get_radius() != range_turret:
		$CollisionShape3D.shape.set_radius(range_turret)
	
	if($mannequin_animation/AnimationPlayer.is_playing()):
		if(round_to_dec($mannequin_animation/AnimationPlayer.get_current_animation_position(),2)>= 2.47 and flag_current_animation):
			throw_projectile()
			throw.emit()
			flag_current_animation = false

	if(!$mannequin_animation/AnimationPlayer.is_playing() and flag_animation_playing):
		print(get_parent().turret_name)
		$mannequin_animation/AnimationPlayer.play("Armature|mixamo_com|Layer0")
		flag_current_animation = true
		
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

	$mannequin_animation/AnimationPlayer.play("Armature|mixamo_com|Layer0")
	$"../../.."/Projectiles.add_child(p)
	p.global_position = $mannequin_animation/Marker3D.global_position
	p.enemy_pos = liste_enemy[0].global_position
	p.parent_pos = $mannequin_animation/Marker3D.global_position
	p.damage = damage
	p.pierce = pierce
	p.speed = bullet_speed


func throw_projectile(angle = 0):
	var p = projectile.instantiate()

	$"../../.."/Projectiles.add_child(p)
	p.global_position = $mannequin_animation/Marker3D.global_position                
	p.enemy_pos = liste_enemy[0].global_position
	p.angle = angle
	p.parent_pos = $mannequin_animation/Marker3D.global_position
	p.damage = damage
	p.pierce = pierce
	p.speed = bullet_speed
#gestion détection enemies
#_______________________________________________________________________________________________________________________________
func _on_area_entered(area: Area3D) -> void:
	liste_enemy.append(area)
	if len(liste_enemy) == 1:
		flag_animation_playing = true
		$mannequin_animation/AnimationPlayer.play("Armature|mixamo_com|Layer0")

func _on_area_exited(area: Area3D) -> void:
	liste_enemy.erase(area)
	if len(liste_enemy) == 0:
		if$mannequin_animation/AnimationPlayer.is_playing():
			$mannequin_animation/AnimationPlayer.stop()
			flag_animation_playing = false
		flag_current_animation = true


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

func round_to_dec(num, digit):
	return round(num * pow(10.0, digit)) / pow(10.0, digit)
