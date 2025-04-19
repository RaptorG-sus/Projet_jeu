extends Control

@export_file("*.tscn") var menu = "res://scene/control/menu_test.tscn"
@export_file("*.tscn") var level = "res://scene/test_map/scene_test.tscn"

var flag = true

func _process(delta: float) -> void:
	if get_parent().get_parent().life <= 0 and flag:
		flag = false
		$death_menu_animation.play("open_menu")
		get_tree().paused = true


func _on_retry_pressed() -> void:
	get_tree().paused = false
	queue_free()
	get_tree().change_scene_to_file(level)


func _on_menu_pressed() -> void:
	get_tree().paused = false
	queue_free()
	get_tree().change_scene_to_file(menu)
