extends Node

func throw_projectile_mod(angle, number, damage, pierce, bullet_speed, enemy_pos, origin_pos, projectile, projectile_node, mode, life_time):
	var angle_depart = (angle*(number-1))/2
	for i in range(number):
		throw_projectile(angle_depart*i, damage, pierce, bullet_speed, enemy_pos, origin_pos, projectile, projectile_node,mode,life_time)

func throw_projectile(angle, damage, pierce, bullet_speed, enemy_pos, origin_pos, projectile, projectile_node,mode,life_time):
	var p = projectile.instantiate()
	p.enemy_pos = enemy_pos
	projectile_node.add_child(p)
	p.global_position = origin_pos          
	p.angle = angle
	p.parent_pos = origin_pos
	p.damage = damage
	p.pierce = pierce
	p.speed = bullet_speed
	p.mode = mode
	p.life_time = life_time
	
func sharpnel_func(damage,speed,pos_origin,child_projectile,life_time,ban_enemy):
	for i in [[1,1],[-1,-1],[-1,1],[1,-1],[1,0],[-1,0],[0,1],[0,-1]]:
		var sharpnel = child_projectile.instantiate()
		$"..".add_child(sharpnel)
		sharpnel.parent_pos = pos_origin
		sharpnel.enemy_pos.x = pos_origin.x + i[0]
		sharpnel.enemy_pos.y = pos_origin.y
		sharpnel.enemy_pos.z = pos_origin.z + i[1]
		sharpnel.global_position = pos_origin
		sharpnel.damage = damage / 2
		sharpnel.pierce = 1
		sharpnel.angle = 0
		sharpnel.speed = speed
		sharpnel.life_time = life_time
		sharpnel.ban_enemy = ban_enemy