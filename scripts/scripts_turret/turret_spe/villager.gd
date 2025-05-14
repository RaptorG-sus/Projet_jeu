extends Node3D

var turret_name = "villager"
var villager_data = GameData.turret_data["villager"]
var flag_nature_tier3 = false

func upgrade_gen(data):
	for deep_data in data:
		print(deep_data)
		match deep_data:
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
	$particules/upgrade.emitting = true
	$Area3D/mannequin_animation/Armature/Skeleton3D/magique_tier1.show()

func upgrade_magique_tier2():
	upgrade_gen(villager_data["magique"]["tier 2"])
	$particules/upgrade.emitting = true
	$Area3D/mannequin_animation/Armature/Skeleton3D/magique_tier1.hide()
	$Area3D/mannequin_animation/Armature/Skeleton3D/magique_tier2.show()



func upgrade_nature_tier1():
	upgrade_gen(villager_data["nature"]["tier 1"])
	$particules/upgrade.emitting = true
	$Area3D/mannequin_animation/Armature/Skeleton3D/natural_tier1.show()

func upgrade_nature_tier2():
	upgrade_gen(villager_data["nature"]["tier 2"])
	$particules/upgrade.emitting = true

func upgrade_nature_tier3():
	flag_nature_tier3 = true
	$particules/upgrade.emitting = true
	$Area3D/mannequin_animation/Armature/Skeleton3D/natural_tier3.show()
	$Area3D/mannequin_animation/Armature/Skeleton3D/Cube_002.hide()

func _on_area_3d_throw() -> void:
	if flag_nature_tier3:
		$Area3D.throw_projectile(15)
		$Area3D.throw_projectile(-15)
