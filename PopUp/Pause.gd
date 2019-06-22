extends Control

func _input(event):
	if event.is_action_pressed("pause"):
		# simple pause menu
		#var new_paused_state = not get_tree().paused
		#get_tree().paused = new_paused_state
		#visible = new_paused_state
		
		# only unpause if the pause menu is up
		if get_tree().paused and visible:
			get_tree().paused = false
			visible = false
		# open up the pause menu if it is not paused
		elif not get_tree().paused:
			get_tree().paused = true
			visible = true