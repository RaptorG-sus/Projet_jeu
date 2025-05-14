extends Area3D


var enemy_pos :Vector3
var parent_pos :Vector3
var damage
var pierce
var speed
var angle

func _ready() -> void:
	await get_tree().process_frame
	look_at(enemy_pos)

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

	if(angle != 0.0):
		var angle_rad = deg_to_rad(angle)
		var y_rotation = Basis(Vector3.UP, angle_rad)
		vecteur_directeur = y_rotation * vecteur_directeur
		vecteur_directeur = vecteur_directeur.normalized()

	return vecteur_directeur


func _on_timer_timeout() -> void:
	queue_free()


func _on_area_entered(area:Area3D) -> void:
	if pierce == 1:			#inflige les dégats avant de soustraire le "pierce", donc fait faire n+1
		queue_free()
	pierce -= 1 

