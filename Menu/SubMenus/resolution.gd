extends HBoxContainer

signal change_resolution

var buttons

func _ready():
	buttons = get_children()
	emit_signal("change_resolution", Vector2(1280, 720))