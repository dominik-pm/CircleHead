extends Node

var current_level = 2

func _ready():
	change_scene("Menu/Menu.tscn")

func _input(event):
	if event.is_action_pressed("toggle_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen

# --> LEVEL CALLED FUNCTIONS: -->
# <-- LEVEL CALLED FUNCTIONS <--

# --> CONTROL CALLED FUNCTIONS: -->
func play_next_level():
	# set current level to next level
	current_level+=1
	# load the level
	play_current_level()
	pass
	
func play_current_level():
	# load current level
	var level = "res://Levels/Level " + str(current_level) + ".tscn"
	var file = File.new()
	if file.file_exists(level):
		change_scene(level)
	else:
		# probably done with the last level
		print(level + ", does not exist")
# <-- CONTROL CALLED FUNCTIONS <--
	
# --> HELP FUNCTIONS -->
# function to set a scene with a path
func change_scene(scene_path):
	get_tree().paused = false
	print("changed scene to: " + str(scene_path))
	get_tree().change_scene(scene_path)
# <-- HELP FUNCTIONS <--