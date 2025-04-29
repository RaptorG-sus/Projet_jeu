extends PathFollow3D

var camera_data = GameData.camera_data["map_test"]
var camera_speed = 10

var pos :int = 0
var epsilon = 0.005
var next_pos :float = 0.0
var actual_pos :float = 0.0
var len = len(camera_data)
var can_move :bool = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

# On suppose le sens de progression dans le sens horaire
	if (next_pos - epsilon) > progress_ratio :
		progress_ratio += delta * camera_speed / (10*len)
	elif (next_pos + epsilon) < progress_ratio:
		progress_ratio -= delta * camera_speed / (10*len)
	else :
		can_move = true
		actual_pos = next_pos
		progress_ratio = next_pos
		
		

func _input(_event: InputEvent) -> void:
	
	if Input.is_action_just_pressed("goto_left") && can_move:
		can_move = false
		if actual_pos == 1:
			actual_pos = 0
			progress_ratio = 0
			pos = 0
		next_pos = actual_pos + (camera_data[pos +1] - camera_data[pos])
		pos+=1
		
	if Input.is_action_just_pressed("goto_right") && can_move:
		can_move = false
		if actual_pos == 0:
			actual_pos = 1
			progress_ratio = 1
			pos = len-1
		next_pos = actual_pos + (camera_data[pos -1] - camera_data[pos])
		pos-=1

 
