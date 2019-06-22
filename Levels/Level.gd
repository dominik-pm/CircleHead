extends Node2D

export(Array, PackedScene) var guns
export(Array, Image) var gun_sprites
export var next_wave_wait_time = 5

var timer_next_wave = null

var all_enemyspawner = []
var item
var waves = []
var i_current_wave = 0 # the index of the current wave

# Pop up
var gameover_popup
var levelsuccess_popup
var messagebox_popup

func _ready():
	# play start sound
	get_node("/root/SFX").play_from_bank("level_start")
	
	# next wave timer
	timer_next_wave = Timer.new()
	timer_next_wave.wait_time = next_wave_wait_time
	timer_next_wave.one_shot = true
	timer_next_wave.connect("timeout", self, "on_timeout_nextwave_complete")
	add_child(timer_next_wave)
	
	# Pop Ups
	gameover_popup = get_node("PopUps/GameOver")
	levelsuccess_popup = get_node("PopUps/LevelSuccess")
	messagebox_popup = get_node("PopUps/MessageBox")
	
	# add all enemyspawners to the array
	for spawner in get_node("Enemyspawners").get_children():
		all_enemyspawner.push_back(spawner)
	
	# get the item
	item = preload("res://Environment/Item.tscn")

	# catch errors
	if guns.size() != gun_sprites.size():
		print('The Gun count does not equal the gun sprites count!')
		get_tree().quit()
	if guns.size() < 1:
		print('There are no guns set for this level!')
		get_tree().quit()
	
	# get waves
	waves = get_node("Waves").get_children()
	
	# show level info
	messagebox_popup.show_msg(self.name)
	
	# start wave
	timer_next_wave.start()

# -- FUNCTIONS CALLED BY THE CURRENT WAVE -->
func on_wave_spawn_enemy(e):
	# spawn it at a random spawner
	randomize()
	var r = floor(rand_range(0, all_enemyspawner.size()))
	
	all_enemyspawner[r].spawn_enemy(e)
	
func on_wave_complete(wave):
	if get_node("Enemys").get_child_count() == 0:
		next_wave()
		wave.queue_free() # maybe better alternative
		print("wave completed")
# <-- FUNCTIONS CALLED BY THE CURRENT WAVE--

func next_wave():
	i_current_wave += 1 # set the current wave to the next wave
	
	# check if it was already the last wave
	if i_current_wave >= waves.size():
		level_success()
	else:
		# show wave completed info
		messagebox_popup.show_msg("Wave " + str(i_current_wave) + " completed!")
		timer_next_wave.start()

func on_timeout_nextwave_complete():
	# play new wave sound
	get_node("/root/SFX").play_from_bank("new_wave")
	# show new wave info
	messagebox_popup.show_msg("Wave " + str(i_current_wave+1) + " aproaching!")
	# start next wave
	waves[i_current_wave].start_wave()

func spawn_item(x, y):
	# instance() the item
	var i = item.instance()
	i.init(x, y)

	# add item as child
	get_node("Items").add_child(i)

func game_over():
	# play gameover sound
	get_node("/root/SFX").play_from_bank("gameover")
	# pause game
	get_tree().paused = true
	# show pop up (backtomenu, restartlevel)
	gameover_popup.show()
	
func level_success():
	# pause game	
	get_tree().paused = true	
	# show pop up (backtomenu, nextlevel)	
	levelsuccess_popup.show()	