extends Node2D

export(Array, PackedScene) var guns
export(Array, Image) var gun_sprites
export (Array, PackedScene) var enemys

var all_enemyspawner = []

var item

# Pop up
var gameover_popup
var levelsuccess_popup

# Timer
var timer
export var spawn_interval = 3.5

func on_timeout_complete():
	spawn_enemy()
	timer.start()

func _ready():
	# play start sound
	get_node("/root/SFX").play_from_bank("level_start")
	
	# Pup Ups
	gameover_popup = get_node("PopUps/GameOverPopUp")
	
	# temporary spawn Timer (should be replaced by a wave somehow)
	timer = Timer.new()
	timer.wait_time = spawn_interval
	timer.connect("timeout", self, "on_timeout_complete")
	timer.start()
	add_child(timer)
	
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


func spawn_enemy():
	var r = 0
	var e = null
	var cnt = 0
	
	
	for enemy in enemys:
		var probability = enemy.instance().spawn_probability
		randomize()
		r = floor(rand_range(0, 11-probability))
		if r == 0:
			e = enemy
	
	if e == null:
		e = enemys[0]
	
	randomize()
	r = floor(rand_range(0, all_enemyspawner.size()))
	all_enemyspawner[r].spawn_enemy(e)

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