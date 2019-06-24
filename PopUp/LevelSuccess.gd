extends Control

func _on_Menu_pressed():
	get_node("/root/global").change_scene("res://Menu/Menu.tscn")

func _on_Nextlevel_pressed():
	get_node("/root/global").play_current_level()
