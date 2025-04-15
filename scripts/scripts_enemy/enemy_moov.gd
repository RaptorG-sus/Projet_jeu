extends PathFollow3D

var enemy_data = GameData.enemy_data
var nom_enemy
var vie
var speed
var damage
var mana_recu

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if get_progress_ratio() == 0:
		nom_enemy = retire_chiffre(str(name))
		speed = enemy_data[nom_enemy]["speed"]
		vie = enemy_data[nom_enemy]["life"]
		mana_recu = vie
		damage = enemy_data[nom_enemy]["damage"]
	move(delta)
	if get_progress_ratio() == 1.0:
		queue_free()
		get_parent().get_parent().get_parent().get_parent().life -= damage
	if vie <= 0:
		queue_free()
		get_parent().get_parent().get_parent().get_parent().mana += mana_recu

func move(delta):
	progress += speed*delta

func retire_chiffre(nom):
	var nom_final = ''
	for i in nom:
		if !(i in ['0','1','2','3','4','5','6','7','8','9']):
			nom_final = nom_final + i
	return nom_final
		
func _on_base_area_entered(area:Area3D) -> void:
	vie -= area.damage
	print(vie)
