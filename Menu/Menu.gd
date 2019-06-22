extends Node2D

func _ready():
	get_node("StartLevel").text = "Play Level " + str(get_node("/root/global").current_level)

func _on_StartLevel_pressed():
	get_node("/root/global").play_current_level()
