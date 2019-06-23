extends Node2D

signal mobile_move

func _ready():
	self.connect("mobile_move", get_parent().get_parent().get_node("Character"), "on_mobile_move")

func _on_left_pressed():
	emit_signal("mobile_move", Vector2(-1,0))

func _on_right_pressed():
	emit_signal("mobile_move", Vector2(1,0))

func _on_down_pressed():
	emit_signal("mobile_move", Vector2(0,1))

func _on_up_pressed():
	emit_signal("mobile_move", Vector2(0,-1))

func _on_stop_pressed():
	emit_signal("mobile_move", Vector2(0,0))