extends PathFollow3D

var enemy_data = GameData.enemy_data
var nom_enemy
var life
var speed
var damage

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if get_progress_ratio() == 0:
		nom_enemy = retire_chiffre(str(name))
		speed = enemy_data[nom_enemy]["speed"]
		life = enemy_data[nom_enemy]["life"]
		damage = enemy_data[nom_enemy]["damage"]
	move(delta)
	if get_progress_ratio() == 1.0:
		queue_free()
		get_parent().get_parent().get_parent().life -= damage

func move(delta):
	progress += speed*delta

func retire_chiffre(nom):
	var nom_final = ''
	for i in nom:
		if !(i in ['0','1','2','3','4','5','6','7','8','9']):
			nom_final = nom_final + i
	return nom_final
		
