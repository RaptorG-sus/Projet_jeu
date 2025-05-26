extends Node

var turret_Origin = {
	"villager": {
		"cost_gen" = 200,
		"cost_magique" = 200,
		"cost_nature" = 100,
		"cost_militaire" = 0, #à décider
		"cost_scientifique" = 0,
		"range_turret" = 5,
		"damage" = 1000,
		"attack_speed" = 1,
		"bullet_speed" = 30,
		"pierce" = 1,
		"angle" = 0,
		"bullet_number" = 1,
		"index_animation" = 0,
		"throw_length_animation" = 2.47, 		
		"shape" = load("res://3d_models/character/mannequin_animation.tscn"),
		"projectile" =load("res://scene/props/Projectiles/projectile.tscn")
	},
	"cannon":{
		"cost_gen" = 200,
		"cost_magique" = 200,
		"cost_nature" = 100,
		"cost_militaire" = 0, #à décider
		"cost_scientifique" = 0,
		"range_turret" = 5,
		"damage" = 1000,
		"attack_speed" = 1,
		"bullet_speed" = 30,
		"pierce" = 1,
		"angle" = 0,
		"bullet_number" = 1,
		"index_animation" = 0,
		"throw_length_animation" = 0.5,
		"shape" = load("res://3d_models/character/props_character/cannon/scene/cannon.tscn"),
		"projectile" =load("res://scene/props/Projectiles/projectile.tscn")
	}
}
func upgrade_tot(turret , tiers : int, categorie  = "base"):
	print(turret.turret_name)
	name = turret.turret_name
	match name:
		"villager":
			match categorie:
				"nature":
					match tiers:
						1:
							turret.cost_nature = 400
							turret.pierce = 2
							turret.shape.get_node("Armature").get_node("Skeleton3D").get_node("natural_tier1").show()
						2:
							turret.cost_nature = 0
							turret.pierce = 3
							turret.projectile = preload("res://scene/props/Projectiles/projectile_nature_village.tscn")
						3:
							turret.cost_nature = 8000
							turret.angle = 15
							turret.bullet_number = 3
							turret.shape.get_node("Armature").get_node("Skeleton3D").get_node("natural_tier3").show()
							turret.shape.get_node("Armature").get_node("Skeleton3D").get_node("Cube_002").hide()

				"magique":
					match tiers:
						1:
							turret.cost_magique = 600
							turret.range_turret = 6
							turret.shape.get_node("Armature").get_node("Skeleton3D").get_node("magique_tier1").show()
						2:
							turret.cost_magique = 1000
							turret.damage = 10
							turret.range_turret = 7
							turret.shape.get_node("Armature").get_node("Skeleton3D").get_node("magique_tier1").hide()
							turret.shape.get_node("Armature").get_node("Skeleton3D").get_node("magique_tier2").show()
