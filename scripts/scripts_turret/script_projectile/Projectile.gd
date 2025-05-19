extends Area3D


var enemy_pos :Vector3
var parent_pos :Vector3
var damage
var pierce
var speed
var angle
var flag_sharpnel

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

func sharpnel_func():
	var compt = 0
	var child_projectile = load(get_scene_file_path())
	for i in [[1,1],[-1,-1],[-1,1],[1,-1],[1,0],[-1,0],[0,1],[0,-1]]:
		var sharpnel = child_projectile.instantiate()
		$"..".add_child(sharpnel)
		sharpnel.parent_pos = global_position
		sharpnel.enemy_pos.x = global_position.x + i[0]
		sharpnel.enemy_pos.y = global_position.y
		sharpnel.enemy_pos.z = global_position.z + i[1]
		sharpnel.damage = damage / 2
		sharpnel.pierce = 1
		sharpnel.angle = compt*45
		sharpnel.speed = speed
		compt += 1
		sharpnel.flag_sharpnel = false


func _on_timer_timeout() -> void:
	queue_free()


func _on_area_entered(area:Area3D) -> void:
	if pierce == 1:			#inflige les dégats avant de soustraire le "pierce", donc fait faire n+1
		if flag_sharpnel:
			sharpnel_func()
		queue_free()
		
	pierce -= 1 
