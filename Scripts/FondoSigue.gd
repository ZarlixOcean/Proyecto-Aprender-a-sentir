extends Sprite2D

func _process(_delta):
	var cam = get_viewport().get_camera_2d()
	if cam:
		global_position.x = cam.get_screen_center_position().x
