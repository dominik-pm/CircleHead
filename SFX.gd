extends Node2D

var settings_soundfx_volume = 50 # 0 - 100
var settings_music_volume = 50   # 0 - 100

# in db
var soundfx_max_decibel = 0
var soundfx_min_decibel = -30
var music_max_decibel = 0
var music_min_decibel = -30

export var max_voices = 10


# -- SETTINGS CALLED FUNCTIONS -->
func set_soundfx_volume(value): # value = 0 - 100
	settings_soundfx_volume = value
	
func set_music_volume(value): # value = 0 - 100
	settings_music_volume = value
# <-- SETTINGS CALLED FUNCTIONS --

# -- PLAY SOUND -->
func play_sample(sample : AudioStream):
	var player = AudioStreamPlayer.new()
	$playing_sounds.add_child(player)
	player.stream = sample
	var db = get_soundfx_decibel()
	player.volume_db = db
	player.play()
	player.connect("finished", self, "on_sound_finished")
func on_sound_finished():
	$playing_sounds.get_child(0).queue_free()

	if $playing_sounds.get_child_count() > max_voices:
		$playing_sounds.get_child(0).queue_free()

func play_from_bank(name : String):
	var db = get_soundfx_decibel()
	get_node(name).volume_db = db
	get_node(name).play()
# <-- PLAY SOUND --

func get_soundfx_decibel():
	# calculate the percent
	var percent = settings_soundfx_volume/100
	if percent == 0:
		return -80 # 0% --> inaudible
	
	var volume_span = soundfx_max_decibel - soundfx_min_decibel
	
	# calculate the new volume based on the percent
	var db = volume_span * percent
	db += soundfx_min_decibel
	
	return db

func get_music_decibel():
	# calculate the percent
	var percent = settings_music_volume/100
	if percent == 0:
		return -80 # 0% --> inaudible
	
	var volume_span = music_max_decibel - music_min_decibel
	
	# calculate the new volume based on the percent
	var db = volume_span * percent
	db += music_min_decibel
	
	return db