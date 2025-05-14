extends Button

# utilisation d'un button pour le futur drag & drop et le placement auto des cartes

@onready var card_name :String
var card_data = GameData.card_data

signal mouse_in(vector: Vector2, click:bool, button_statment:bool)


func _ready() -> void:
	$card.texture = load(card_data[card_name]["texture"])
	text = card_data[card_name]["text"]
	$card.scale = Vector2(8,8)


func _mouse_enter() -> void:
	mouse_in.emit(get_global_mouse_position(), false, false)
	$animation.play("test")
	self.z_index += 5
	$card.scale *= 2


func _mouse_exit() -> void:
	
	$animation.play("card_go_down")
	self.z_index -= 5
	$card.scale /= 2
	

func _on_button_down() -> void:
	mouse_in.emit(get_global_mouse_position(), true, false)
	


func _on_button_up() -> void:
	mouse_in.emit(get_global_mouse_position(), true, true)
