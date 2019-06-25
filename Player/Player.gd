extends Node2D

func set_camera_max_pos(pos : Vector2):
	$Character/Pivot/CameraOffset/Cam.limit_right = pos.x
	$Character/Pivot/CameraOffset/Cam.limit_bottom = pos.y