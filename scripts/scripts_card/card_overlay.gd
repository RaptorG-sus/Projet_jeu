extends Button

# utilisation d'un button pour le futur drag & drop et le placement auto des cartes

@onready var card_name :String
var card_data = GameData.card_data


func _ready() -> void:
	$card.texture = load(card_data[card_name]["texture"])
	text = card_data[card_name]["text"]
	$card.scale = Vector2(8,8)

	
func _mouse_enter() -> void:

	$animation.play("test")
	self.z_index += 5
	$card.scale *= 2

	

func _mouse_exit() -> void:
	
	$animation.play("card_go_down")
	self.z_index -= 5
	$card.scale /= 2
	
