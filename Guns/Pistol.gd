extends "res://Guns/Gun.gd"

# doesnt work, change this input code to player (dunno if thats good)

# override this function to only check shot when key is clicked and not on hold 
func check_input(dir):
	if Input.is_action_just_pressed("player_shoot"):
		check_shoot(dir)