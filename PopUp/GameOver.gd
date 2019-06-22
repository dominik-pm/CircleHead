extends Control

func _on_next_level_pressed():
	get_node("/root/global").play_next_level()
	
func _on_Menu_pressed():
	get_node("/root/global").change_scene("res://Menu/Menu.tscn")
