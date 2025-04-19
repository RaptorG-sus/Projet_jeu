extends Control

func _process(delta: float) -> void:
	$TextEdit.text = str(get_parent().get_parent().piece)