extends Node2D

signal mobile_move

func _ready():
	self.connect("mobile_move", get_parent().get_parent().get_node("Character"), "on_mobile_move")

func _input(event):
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		if $TouchControls/left.is_pressed():
			InputMap.call("ui_left")
		if $TouchControls/right.is_pressed():
			InputMap.call("ui_right")
		if $TouchControls/up.is_pressed():
			InputMap.call("ui_up")
		if $TouchControls/down.is_pressed():
			InputMap.call("ui_down")

func _on_left_pressed():
	#InputMap.call("ui_left")
	pass

func _on_right_pressed():
	#InputMap.call("ui_left")
	pass

func _on_down_pressed():
	#InputMap.call("ui_left")
	pass

func _on_up_pressed():
	#InputMap.call("ui_left")
	pass