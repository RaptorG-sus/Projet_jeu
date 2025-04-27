extends Area3D


func _mouse_enter() -> void:
	print(name)

	$animation.play("test")
	$hitbox.position.y = 0.28
	$hitbox.shape.size.x = 1.578
	$hitbox.position.z += 0.03
	$card.render_priority += 5
	


func _mouse_exit() -> void:
	$animation.play("card_go_down")
	$hitbox.position.y = -0.44
	$hitbox.shape.size.x = 1.32
	$hitbox.position.z -=0.03
	$card.render_priority -= 5


