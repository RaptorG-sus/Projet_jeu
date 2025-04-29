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
		$".."/Area3D.damage += data_temp["damage"]
		$".."/Area3D.range_turret += data_temp["range"]
		#tier_magique += 1
		$".."/particules/upgrade.emitting = true
	
func _on_magique_pressed() -> void:
	upgrade("magique")
