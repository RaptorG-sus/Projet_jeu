extends Area3D

signal enemy_died

var projectile :PackedScene = preload("res://scene/props/projectile.tscn")
var turret_data = GameData.turret_data

@onready var current_enemy = null
var liste_enemy = []

func _ready() -> void:
	$Timer.set_wait_time(turret_data["turret_test"]["base"]["attack_speed"])
	$CollisionShape3D.shape.set_radius(turret_data["turret_test"]["base"]["range"])
	
func _process(delta: float) -> void:
	if len(liste_enemy) != 0:
		look_at(liste_enemy[0].global_position)
	else:
		smooth_rotation()
		
		
func smooth_rotation() -> void:
	var r = Vector3.ZERO
	var ratio = 0.1
	var rotation_need = rotation
	
	if rotation != r:
		rotation -= rotation_need*ratio


func _on_timer_timeout() -> void:
	var p = projectile.instantiate()

	$"../.."/Projectiles.add_child(p)
	p.global_position = global_position
	p.enemy_pos = liste_enemy[0].global_position
	p.parent_pos = global_position
	p.damage = turret_data["turret_test"]["base"]["damage"]
	p.pierce = turret_data["turret_test"]["base"]["pierce"]
	p.speed = turret_data["turret_test"]["base"]["bullet_speed"]


func _on_area_entered(area: Area3D) -> void:
	liste_enemy.append(area)
	if len(liste_enemy) == 1:
		$Timer.start()


func _on_area_exited(area: Area3D) -> void:
	enemy_died.emit()
	liste_enemy.erase(area)
	if len(liste_enemy) == 0:
		$Timer.stop()
