extends Popup

func show_msg(msg):
	$VBoxContainer/CenterContainer/Panel/CenterContainer/Label.text = msg
	popup()
	$AnimationPlayer.play("popup")

func _on_AnimationPlayer_animation_finished(anim_name):
	hide()
