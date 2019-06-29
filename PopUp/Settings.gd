extends Control

func _ready():
	# init the volume sliders with correct values
	$SoundFX_Volume.value = get_node("/root/SFX").settings_soundfx_volume
	$Music_Volume.value = get_node("/root/SFX").settings_music_volume

func _on_Restart_pressed():
	get_node("/root/global").play_current_level()

func _on_Menu_pressed():
	get_node("/root/global").change_scene("res://Menu/TitleScreen.tscn")

func _on_Resume_pressed():
	hide()
	# unpause game
	get_tree().paused = false

# TOGGLE SOUND/MUSIC ON/OFF
func _on_SoundFX_toggled(button_pressed):
	if $SoundFX_Toggle.pressed:
		$SoundFX_Volume.value = 50
	else:
		$SoundFX_Volume.value = 0
func _on_Music_toggled(button_pressed):
	if $Music_Toggle.pressed:
		$Music_Volume.value = 50
	else:
		$Music_Volume.value = 0

# TELL SFX script that the voluem has changed (value from 0 to 100)
func _on_SoundFX_Volume_value_changed(value):
	get_node("/root/SFX").set_soundfx_volume(value)
	$SoundFX_Toggle.pressed = true
	if value == 0:
		$SoundFX_Toggle.pressed = false

func _on_Music_Volume_value_changed(value):
	get_node("/root/SFX").set_music_volume(value)
	$Music_Toggle.pressed = true
	if value == 0:
		$Music_Toggle.pressed = false
