extends "res://Guns/Gun.gd"

# override this function to get rapid fire
func check_input(dir):
	if Input.is_action_pressed("player_shoot"):
		check_shoot(dir)