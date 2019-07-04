extends Node

var current_level = 1

var settings = {
	"sfx":true,
	"sfx_volume":50,
	"music":true,
	"music_volume":50,
	"fullscreen":false,
	"resolution":Vector2(1920, 1080)
}

func _ready():
	# display the title screen on startup
	change_scene("Menu/TitleScreen.tscn")

func _input(event):
	if event.is_action_pressed("toggle_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen

# --> LEVEL CALLED FUNCTIONS: -->
func level_set_next():
	current_level+=1
# <-- LEVEL CALLED FUNCTIONS <--

# --> CONTROL CALLED FUNCTIONS: -->
func change_setting(setting, value):
	if settings[setting] != null:
		settings[setting] = value
		update_settings()
	else:
		print(setting + ' is not a valid setting!')
# <-- CONTROL CALLED FUNCTIONS: <--
	
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
func update_settings():
	get_node("/root/SFX").set_soundfx_volume(settings["sfx_volume"])
	get_node("/root/SFX").set_music_volume(settings["music_volume"])
	
	OS.window_fullscreen = settings["fullscreen"]


# function to set a scene with a path
func change_scene(scene_path):
	get_tree().paused = false
	print("changed scene to: " + str(scene_path))
	# -- TEMPORARY FIX TO CLEAR BULLETS AFTER SCENE CHANGE -->
	var nodes = get_node("/root").get_children()
	for node in nodes:
		if node.is_in_group('bullet'):
			node.queue_free()
	# <-- TEMPORARY FIX TO CLEAR BULLETS AFTER SCENE CHANGE --
	get_tree().change_scene(scene_path)
# <-- HELP FUNCTIONS <--