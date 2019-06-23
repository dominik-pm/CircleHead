extends Control

func _on_Restart_pressed():
	get_node("/root/global").play_current_level()
	
func _on_Menu_pressed():
	get_node("/root/global").change_scene("res://Menu/Menu.tscn")
