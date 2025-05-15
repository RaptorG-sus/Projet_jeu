extends Node

func upgrade_tot(turret , tiers : int, categorie  = "base"):
	print(turret.turret_name)
	name = turret.turret_name
	match name:
		"villager":
			match categorie:
				"base":
					turret.cost_gen = 200
					turret.cost_magique = 200
					turret.cost_nature = 100
					turret.cost_militaire = 0 #à décider
					turret.cost_scientifique = 0
					turret.range_turret = 5
					turret.damage = 1000
					turret.attack_speed =1.25
					turret.bullet_speed = 30
					turret.pierce = 1
					turret.angle = 0
					turret.bullet_number = 1
					turret.shape = load("res://3d_models/character/mannequin_animation.tscn")
					turret.projectile = preload("res://scene/props/projectile.tscn")
				"nature":
					match tiers:
						1:
							turret.cost_nature = 400
							turret.pierce = 2
							turret.shape.get_node("Armature").get_node("Skeleton3D").get_node("natural_tier1").show()
						2:
							turret.cost_nature = 0
							turret.pierce = 3
						3:
							turret.cost_nature = 8000
							turret.angle = 15
							turret.bullet_number = 3
							turret.shape.get_node("Armature").get_node("Skeleton3D").get_node("natural_tier3").show()
							turret.shape.get_node("Armature").get_node("Skeleton3D").get_node("Cube_002").hide()
