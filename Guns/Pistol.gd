extends "res://Guns/Gun.gd"

# override this function to only check shot when key is clicked and not on hold 
func check_input(dir):
	if Input.is_action_just_pressed("player_shoot"):
		check_shoot(dir)