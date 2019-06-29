extends Control

func _on_Restart_pressed():
	get_node("/root/global").play_current_level()

func _on_Menu_pressed():
	get_node("/root/global").change_scene("res://Menu/TitleScreen.tscn")

func _on_Resume_pressed():
	hide()
	# unpause game
	get_tree().paused = false