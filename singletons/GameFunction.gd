extends Node

func throw_projectile_mod(angle, number, damage, pierce, bullet_speed, enemy_pos, origin_pos, projectile, projectile_node):
	var angle_depart = (angle*(number-1))/2
	for i in range(number):
		throw_projectile(angle_depart*i, damage, pierce, bullet_speed, enemy_pos, origin_pos, projectile, projectile_node)

func throw_projectile(angle, damage, pierce, bullet_speed, enemy_pos, origin_pos, projectile, projectile_node):
	var p = projectile.instantiate()

	p.enemy_pos = enemy_pos
	projectile_node.add_child(p)
	p.global_position = origin_pos          
	p.angle = angle
	p.parent_pos = origin_pos
	p.damage = damage
	p.pierce = pierce
	p.speed = bullet_speed
