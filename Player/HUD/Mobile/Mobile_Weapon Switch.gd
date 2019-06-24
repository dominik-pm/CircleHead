extends Node2D

signal mobile_switchweapon

func _ready():
	self.connect("mobile_switchweapon", get_parent().get_parent().get_node("Character"), "on_mobile_prevgun")

func _on_TouchScreenButton_pressed():
	emit_signal("mobile_switchweapon")
