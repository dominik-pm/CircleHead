extends Node2D

var gun_set = false

func set_icon(icon):
	gun_set = true
	$Icon.texture = icon
	
func select():
	$Icon.modulate = Color(1,1,1)
	
func deselect():
	$Icon.modulate = Color(0.25,0.25,0.25)