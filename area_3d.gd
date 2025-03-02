extends Area3D


var projectile :PackedScene = preload("res://projectile.tscn")

@onready var current_enemy = null
var liste_enemy = []

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
	$".."/Projectiles.add_child(p)
	p.global_position = global_position
	p.enemy_pos = liste_enemy[0].global_position
	p.parent_pos = global_position



func _on_area_entered(area: Area3D) -> void:
	liste_enemy.append(area)
	print(liste_enemy)
	$Timer.start()


func _on_area_exited(area: Area3D) -> void:
	print(liste_enemy)
	liste_enemy.erase(area)
	$Timer.stop()
