extends VBoxContainer

@onready var racine : Node3D = get_parent().get_parent()


func _process(delta: float) -> void:
	$PointDeVie/Label.text = str(racine.life)
	$PointDeMana/Label.text = str(racine.mana)
	$Piece/Label.text = str(racine.piece)
