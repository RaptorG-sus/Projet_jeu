extends Area3D

var prio

func _on_mouse_entered():
	$animation.play("test")
	$hitbox.position.y = -0.04
	$card.render_priority +=2
	


func _on_mouse_exited():
	$animation.play("card_go_down")
	$hitbox.position.y = -0.54
	$card.position.z -= 0.1
	$card.render_priority -= 2
