extends Control

@onready var menu = preload("res://scene/control/menu_test.tscn")


func _on_continue_pressed() -> void:
	hide()
	get_tree().paused = false


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_packed(menu)
