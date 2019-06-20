extends Node2D

var settings_sound_volume = -10

export var max_voices = 10

func play_sample(sample):
	var player = AudioStreamPlayer2D.new()
	$playing_sounds.add_child(player)
	player.stream = sample
	player.volume_db = settings_sound_volume
	player.play()
	player.connect("finished", self, "on_sound_finished")

func on_sound_finished():
	$playing_sounds.get_child(0).queue_free()	

	if $playing_sounds.get_child_count() > max_voices:
		$playing_sounds.get_child(0).queue_free()

func play_from_bank(name):
	get_node(name).volume_db = settings_sound_volume
	get_node(name).play()