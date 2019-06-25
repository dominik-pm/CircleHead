extends Node2D

func _on_Settings_pressed():
	# pause game
	get_tree().paused = true
	# show pop up (backtomenu, restartlevel)
	get_parent().get_parent().get_parent().settings_popup.show()