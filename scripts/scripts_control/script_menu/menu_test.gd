extends Control

@onready var level_test = preload("res://scene/test_map/scene_test.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:						# à modifier : fonction pour lancer la scene principal donc le jeu
	get_tree().change_scene_to_packed(level_test)


func _on_quit_pressed() -> void:						# quitte le jeu
	get_tree().quit()