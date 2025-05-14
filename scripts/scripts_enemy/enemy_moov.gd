class_name Enemy extends PathFollow3D


var enemy_data = GameData.enemy_data
var nom_enemy
var vie
var speed
var damage 
var mana_recu

func _ready():
	pass

signal enemy_died

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if get_progress_ratio() == 0:					# initialise toute les valeurs de l'enemy dès son spawn (j'ai pas reussi autre pars)
		nom_enemy = retire_chiffre(str(name))
		speed = enemy_data[nom_enemy]["speed"]
		vie = enemy_data[nom_enemy]["life"]
		mana_recu = vie
		damage = enemy_data[nom_enemy]["damage"]
	move(delta)										# fonction pour faire bouger l'enemy par rapport à son chemin
	if get_progress_ratio() == 1.0:					# vérification l'enemy est au bout de la map
		$"../../../..".number_enemy -= 1			# soustrait 1 au nombre d'enemy pour pouvoir lancer le shop automatiquement
		queue_free()								# queue free pour retirer l'enemy de la scene 
		get_parent().get_parent().get_parent().get_parent().life -= damage			# infligé les dégats au joueur
	if vie <= 0:									# vérification si la vie est inférieur à 0 (soit quand il est mort) et similaire a l'ancienne condition avec l'ajoue de la mana
		$"../../../..".number_enemy -= 1			
		queue_free()
		get_parent().get_parent().get_parent().get_parent().mana += mana_recu

func move(delta):
	progress += speed*delta

func retire_chiffre(nom):					# fonction pour retirer les chiffres, afin d'avoir seulement le nom de l'enemy et non pas son numéro quand il spawn
	var nom_final = ''
	for i in nom:
		if !(i in ['0','1','2','3','4','5','6','7','8','9']):
			nom_final = nom_final + i
	return nom_final
		
func _on_base_area_entered(area:Area3D) -> void:			# quand le projectile touche l'enemy et donc fait les dégats
	vie -= area.damage
	print(vie)
