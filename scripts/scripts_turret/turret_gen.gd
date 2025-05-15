extends Area3D

var turret_data = GameData.turret_data
var upgrade_tot = TurretData
var turret_function = GameFunction
var flag_menu_upgrade = false
var flag_current_animation = true
var flag_animation_playing = false
#var turret_name : String = $"..".turret_name

# stat de la tours modifié dans turretData avec la fonction upgrade_tot
var attack_speed
var range_turret
var damage 
var pierce 
var bullet_speed 
var angle 
var bullet_number 
var shape 
var projectile

var cost_gen
var cost_magique
var cost_nature
var cost_militaire
var cost_scientifique

signal throw

@onready var turret_name = "villager" 

@onready var current_enemy = null
var liste_enemy = []

# BIEN METTRE L'ANIMATION ET LE MARKER AU NOM DE BASE, SINON LE CODE NE FONCTIONNE PLUS
func _ready() -> void:

	print(self)
	upgrade_tot.upgrade_tot(self,0)
	print(damage)

	shape = shape.instantiate()
	add_child(shape)
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
	
	if(shape.get_node("AnimationPlayer").is_playing()):
		if(round_to_dec(shape.get_node("AnimationPlayer").get_current_animation_position(),2)>= 2.47 and flag_current_animation):
			turret_function.throw_projectile_mod(angle,bullet_number, damage, pierce, bullet_speed, liste_enemy[0].global_position, shape.get_node("Marker3D").global_position, projectile, $"../../.."/Projectiles)
			flag_current_animation = false

	if(!shape.get_node("AnimationPlayer").is_playing() and flag_animation_playing):
		shape.get_node("AnimationPlayer").play("Armature|mixamo_com|Layer0")
		flag_current_animation = true
		
func smooth_rotation() -> void:
	var r = Vector3.ZERO
	var ratio = 0.1
	var rotation_need = rotation
	
	if rotation != r:
		rotation -= rotation_need*ratio

#gestion détection enemies
#_______________________________________________________________________________________________________________________________
func _on_area_entered(area: Area3D) -> void:
	liste_enemy.append(area)
	if len(liste_enemy) == 1:
		flag_animation_playing = true
		shape.get_node("AnimationPlayer").play("Armature|mixamo_com|Layer0")

func _on_area_exited(area: Area3D) -> void:
	liste_enemy.erase(area)
	if len(liste_enemy) == 0:
		if shape.get_node("AnimationPlayer").is_playing():
			shape.get_node("AnimationPlayer").stop()
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
