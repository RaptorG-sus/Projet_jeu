extends Area3D

var turret_name = "cannon"


var turret_data = GameData.turret_data
var upgrade_tot = TurretData
var turret_Origin = TurretData.turret_Origin[turret_name]
var turret_function = GameFunction
var flag_menu_upgrade = false
var flag_current_animation = true
var flag_animation_playing = false
#var turret_name : String = $"..".turret_name

# stat de la tours modifié dans turretData avec la fonction upgrade_tot
var attack_speed = turret_Origin["attack_speed"]
var range_turret= turret_Origin["range_turret"]
var damage = turret_Origin["damage"]
var pierce = turret_Origin["pierce"]
var bullet_speed = turret_Origin["bullet_speed"]
var angle = turret_Origin["angle"]
var bullet_number = turret_Origin["bullet_number"]
var shape = turret_Origin["shape"]
var projectile = turret_Origin["projectile"]

var cost_gen = turret_Origin["cost_gen"]
var cost_magique = turret_Origin["cost_magique"]
var cost_nature = turret_Origin["cost_nature"]
var cost_militaire = turret_Origin["cost_militaire"]
var cost_scientifique = turret_Origin["cost_scientifique"]

var index_animation = turret_Origin["index_animation"]
var throw_length_animation = turret_Origin["throw_length_animation"]

@onready var current_enemy = null
var liste_enemy = []

# BIEN METTRE L'ANIMATION ET LE MARKER AU NOM DE BASE, SINON LE CODE NE FONCTIONNE PLUS
func _ready() -> void:
	print(self)
	upgrade_tot.upgrade_tot(self,0)
	print(damage)

	shape = shape.instantiate()
	add_child(shape)
	

	$".".input_ray_pickable = false
	$Timer.set_wait_time(attack_speed)
	$CollisionShape3D.shape.set_radius(range_turret)

func _process(delta: float) -> void:
	if len(liste_enemy) != 0:
		turret_function.turret_look_at(self,liste_enemy[0].global_position)							#Similaire au look at mais plus complexe pour faire du cas par cas (dans le game function à changé au besoin)
	else:
		smooth_rotation()
	
	
	if $CollisionShape3D.shape.get_radius() != range_turret:
		$CollisionShape3D.shape.set_radius(range_turret)
	
	if(shape.get_node("AnimationPlayer").is_playing()):
		
		if(round_to_dec(shape.get_node("AnimationPlayer").get_current_animation_position(),2)>= throw_length_animation and flag_current_animation and len(liste_enemy) > 0):
			print(GameFunction.find_node(self,"Marker3D"))
			var dir_node_projectile = GameFunction.find_node(self,"Marker3D")
			if dir_node_projectile[1]:
				print(self.get_path_to($Marker3D))
				turret_function.throw_projectile_mod(angle,bullet_number, damage, pierce, bullet_speed, liste_enemy[0].global_position, get_node(str(dir_node_projectile[0])).global_position, projectile, $"../../.."/Projectiles,"sharpnel",1)
				flag_current_animation = false
		if shape.get_node("AnimationPlayer").get_speed_scale()*attack_speed !=  shape.get_node("AnimationPlayer").get_current_animation_length():
			shape.get_node("AnimationPlayer").set_speed_scale(shape.get_node("AnimationPlayer").get_current_animation_length()/attack_speed)

	if(!shape.get_node("AnimationPlayer").is_playing() and flag_animation_playing):
		shape.get_node("AnimationPlayer").play(shape.get_node("AnimationPlayer").get_animation_list()[index_animation])
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
