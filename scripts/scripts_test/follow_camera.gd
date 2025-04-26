extends PathFollow3D

var camera_data = GameData.camera_data
var pos = 0
var camera_speed = 10
signal position_cam(position_cam)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	"""if (progress_ratio != camera_data[get_parent().get_parent().name][pos]):
		if progress_ratio < camera_data[get_parent().get_parent().name][pos]:
			progress += delta * camera_speed 
		if progress_ratio > camera_data[get_parent().get_parent().name][pos]:
			progress -= delta * camera_speed""" 

	if Input.is_action_just_pressed("goto_left"):
		position_cam.emit(global_position)
		pos = (pos + 1)%len(camera_data[get_parent().get_parent().name])
		progress_ratio = camera_data[get_parent().get_parent().name][pos]

	if Input.is_action_just_pressed("goto_right"):
		position_cam.emit(global_position)
		pos = (pos - 1)%len(camera_data[get_parent().get_parent().name]) 
		progress_ratio = camera_data[get_parent().get_parent().name][pos]



func _on_position_cam(position_cam: Variant) -> void:
	pass # Replace with function body.
