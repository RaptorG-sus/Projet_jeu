extends Control

var upgrade_data = GameData.turret_data

var tier_magique = 1
var tier_scientifique = 1
var tier_nature = 1
var tier_militaire = 1

var turret_name = "turret_test"
var turret_data = upgrade_data[turret_name]

func show_menu():
	$AnimationPlayer.play("upgrade_show")

func close_menu():
	$AnimationPlayer.play("upgrade_close")

func upgrade(categorie):
	var data_temp = turret_data[categorie]["tier "+str(tier_magique)]
	print(data_temp)
	if data_temp["cost"] <= $"../../../..".mana:
		$"../../../..".mana-=data_temp["cost"]
		for data in data_temp:
			match data:
				"damage":
					$".."/Area3D.damage += data_temp["damage"]
				"range":
					$".."/Area3D.range_turret += data_temp["range"]
				"pierce":
					$".."/Area3D.pierce += data_temp["pierce"]
				"bullet_speed":
					$".."/Area3D.bullet_speed += data_temp["bullet_speed"]
				"attack_speed":
					$".."/Area3D.attack_speed += data_temp["attack_speed"]
		
		#tier_magique += 1
		$".."/particules/upgrade.emitting = true
	
func _on_magique_pressed() -> void:
	upgrade("magique")


func _on_nature_pressed() -> void:
	upgrade("nature")
	$".."/Area3D/mannequin_animation/Armature/Skeleton3D/natural_tier1.show()
