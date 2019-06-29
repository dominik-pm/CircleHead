extends Control

func _on_Button_pressed():
	get_node("/root/global").change_scene('res://Menu/TitleScreen.tscn')