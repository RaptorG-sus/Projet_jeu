extends Node3D

var liste_enemy = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if len(liste_enemy) > 0:
		$BonhommeEnMousse.look_at(liste_enemy[0].global_transform.origin)

func _on_area_3d_body_entered(body: Node3D) -> void:
	liste_enemy.append(body)
	print("test")

func _on_area_3d_body_exited(body: Node3D) -> void:
	liste_enemy.erase(body)
