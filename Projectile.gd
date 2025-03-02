extends Area3D


@onready var enemy_pos :Vector3
@onready var parent_pos :Vector3

var speed = 25


func _process(delta: float) -> void:
	global_position += delta * speed * vecteur_directeur(parent_pos, enemy_pos)


# From p to e
func vecteur_directeur(p: Vector3, e: Vector3) -> Vector3:
	# p = parent_pos et e = enemy_pos
	var vecteur_directeur = Vector3.ONE
	
	var somme = abs( e.x - p.x ) + abs( e.y - p.y ) + abs( e.z - p.z )
	vecteur_directeur.x = (e.x - p.x) / somme
	vecteur_directeur.y = (e.y - p.y) / somme
	vecteur_directeur.z = (e.z - p.z) / somme

	return vecteur_directeur


func _on_timer_timeout() -> void:
	queue_free()
