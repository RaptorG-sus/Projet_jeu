extends Node3D

var turret_name = "villager"
var villager_data = GameData.turret_data["villager"]

func upgrade_gen(data):
	print(name)
	for deep_data in data:
		match data:
			"damage":
				$Area3D.damage += data["damage"]
			"range":
				$Area3D.range_turret += data["range"]
			"pierce":
				$Area3D.pierce += data["pierce"]
			"bullet_speed":
				$Area3D.bullet_speed += data["bullet_speed"]
			"attack_speed":
				$Area3D.attack_speed += data["attack_speed"]

func upgrade_magique_tier1():
	upgrade_gen(villager_data["magique"]["tier 1"])

func upgrade_nature_tier1():
	upgrade_gen(villager_data["nature"]["tier 1"])
