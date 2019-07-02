extends Control

func _ready():
	$Fade.fade_in()
	
func _on_BackButton_pressed():
	$Fade.show()
	$Fade.fade_out()

func _on_Fade_fade_finished(anim):
	if anim == 'fade_in':
		$Fade.hide()
	else:
		get_node("/root/global").change_scene('res://Menu/TitleScreen.tscn')