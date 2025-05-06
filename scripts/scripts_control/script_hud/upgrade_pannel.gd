extends Control

var upgrade_data = GameData.turret_data

var tier_magique = 1
var tier_scientifique = 1
var tier_nature = 1
var tier_militaire = 1

var turret_name = "villager"
var turret_data = upgrade_data[turret_name]

func show_menu():
	$AnimationPlayer.play("upgrade_show")

func close_menu():
	$AnimationPlayer.play("upgrade_close")
	
func _on_magique_pressed() -> void:
	var cost = turret_data["magique"]["tier "+str(tier_magique)]["cost"]
	if cost <= $"../../../..".mana:
		$"../../../..".mana-=cost
		match tier_magique:
			1:
				$"..".upgrade_magique_tier1()
#			2:
#				$"..".upgrade_magique_tier2()
#			3:
#				$"..".upgrade_magique_tier3()
#			4:
#				$"..".upgrade_magique_tier4()
#			5:
#				$"..".upgrade_magique_tier5()
#		tier_magique+=1

func _on_nature_pressed() -> void:
	var cost = turret_data["nature"]["tier "+str(tier_nature)]["cost"]
	if cost <= $"../../../..".mana:
		$"../../../..".mana-=cost
		match tier_nature:
			1:
				$"..".upgrade_nature_tier1()
#			2:
#				$"..".upgrade_nature_tier2()
#			3:
#				$"..".upgrade_nature_tier3()
#			4:
#				$"..".upgrade_nature_tier4()
#			5:
#				$"..".upgrade_nature_tier5()
#		tier_magique+=1
	$".."/Area3D/mannequin_animation/Armature/Skeleton3D/natural_tier1.show()
