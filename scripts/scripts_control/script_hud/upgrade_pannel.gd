extends Control

var upgrade_data = GameData.turret_data
var upgrade_tot = TurretData

var tier_magique = 1
var tier_scientifique = 1
var tier_nature = 1
var tier_militaire = 1

var turret_gen
var turret_name 
var turret_data

func _ready() -> void:
	turret_gen = $"..".get_child(0)
	turret_name = turret_gen.turret_name
	turret_data = upgrade_data[turret_name]

func show_menu():
	$AnimationPlayer.play("upgrade_show")

func close_menu():
	$AnimationPlayer.play("upgrade_close")
	
func _on_magique_pressed() -> void:
	var cost = turret_gen.cost_magique
	if cost <= $"../../../..".mana:
		$"../../../..".mana-=cost
		match tier_magique:
			1:
				upgrade_tot.upgrade_tot(turret_gen, 1, "magique" )
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
	var cost = turret_gen.cost_nature
	if cost <= $"../../../..".mana:
		$"../../../..".mana-=cost
		match tier_nature:
			1:
				upgrade_tot.upgrade_tot(turret_gen, 1, "nature" )
			2:
				upgrade_tot.upgrade_tot(turret_gen, 2, "nature" )
			3:
				upgrade_tot.upgrade_tot(turret_gen, 3, "nature" )
#			4:
#				$"..".upgrade_nature_tier4()
#			5:
#				$"..".upgrade_nature_tier5()
		tier_nature+=1
	
