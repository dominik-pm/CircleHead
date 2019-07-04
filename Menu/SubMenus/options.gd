extends Control

export (NodePath) var SoundFX_Volume
export (NodePath) var SoundFX_Toggle
export (NodePath) var Music_Volume
export (NodePath) var Music_Toggle

func _ready():
	# init the volume sliders with correct values
	SoundFX_Volume = get_node(SoundFX_Volume)
	Music_Volume = get_node(Music_Volume)
	SoundFX_Toggle = get_node(SoundFX_Toggle)
	Music_Toggle = get_node(Music_Toggle)
	
	SoundFX_Volume.value = get_node("/root/global").settings["sfx_volume"]
	Music_Volume.value = get_node("/root/global").settings["music_volume"]

# TOGGLE SOUND/MUSIC ON/OFF
func _on_SoundFX_toggled(button_pressed):
	if SoundFX_Toggle.pressed:
		SoundFX_Volume.value = 50
	else:
		SoundFX_Volume.value = 0
func _on_Music_toggled(button_pressed):
	if Music_Toggle.pressed:
		Music_Volume.value = 50
	else:
		Music_Volume.value = 0

# TELL SFX script that the voluem has changed (value from 0 to 100)
func _on_SoundFX_Volume_value_changed(value):
	get_node("/root/global").change_setting('sfx_volume', value)
	#get_node("/root/SFX").set_soundfx_volume(value)
	
	# toggle switch on (off if slider is at 0)
	SoundFX_Toggle.pressed = true
	if value == 0:
		SoundFX_Toggle.pressed = false

func _on_Music_Volume_value_changed(value):
	get_node("/root/global").change_setting('music_volume', value)
	#get_node("/root/SFX").set_music_volume(value)
	
	# toggle switch on (off if slider is at 0)
	Music_Toggle.pressed = true
	if value == 0:
		Music_Toggle.pressed = false


func _on_Resolution_change_resolution(new_resolution):
	# change the resolution of the window
	OS.window_size = new_resolution # just changes the window size xd


func _on_Fullscreen_toggled(button_pressed):
	get_node("/root/global").change_setting("fullscreen", !OS.window_fullscreen)