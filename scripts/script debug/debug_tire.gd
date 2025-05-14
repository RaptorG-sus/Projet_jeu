extends Button

@onready var level_debug = preload("res://scene/debut_test/scene_debug_tire.tscn")


func _on_pressed() -> void:
	get_tree().change_scene_to_packed(level_debug)

