extends Control

func show_msg(msg):
	get_node("Panel/Label").text = msg
	show()
	$Timer.start()

func _on_Timer_timeout():
	hide()
