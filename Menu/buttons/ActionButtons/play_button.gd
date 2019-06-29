extends Button

func _ready():
	grab_focus()
	$Label.text = "Play Level " + str(get_node("/root/global").current_level)

func _on_PlayButton_pressed():
	get_node("/root/global").play_current_level()