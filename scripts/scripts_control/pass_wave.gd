extends Control


func shop_on():
	$animationWave.play("shop_go_up")

func shop_down():
	$animationWave.play("shop_go_down")

func wave_up():
	$animationWave.play("wave_go_up")

func wave_down():
	$animationWave.play("wave_go_down")

func inter_wave(number_wave):
	$show_wave/wave_label.text = "wave " + str(number_wave)
	wave_up()
	await (get_tree().create_timer(3,false)).timeout
	wave_down()
	#if marchant alors :
	await (get_tree().create_timer(0.7,false)).timeout
	shop_on()
	


func _on_pass_wave_pressed() -> void:
	shop_down()
