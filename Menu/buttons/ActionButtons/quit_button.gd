extends Button

func _ready():
	grab_focus()

func _on_QuitButton_pressed():
	get_tree().quit()