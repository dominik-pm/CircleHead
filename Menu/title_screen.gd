extends Control

var scene_to_load

func _ready():
	# set the focus of ui to the first button
	$Menu/CenterRow/Buttons/PlayButton.grab_focus()
	
	for button in $Menu/CenterRow/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
	
func _on_Button_pressed(stl):
	scene_to_load = stl
	$Fade.show()
	$Fade.fade_out()

func _on_Fade_fade_finished():
	get_node("/root/global").change_scene(scene_to_load)
