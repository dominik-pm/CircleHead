extends Node2D

export(Array, PackedScene) var guns
export(Array, Image) var gun_sprites

var enemys
var enemyspawner1
var enemyspawner2

var item

# Timer
var timer
export var spawn_interval = 3.5

func on_timeout_complete():
	spawn_enemy()
	timer.start()

func _ready():
	# Timer
	timer = Timer.new()
	timer.wait_time = spawn_interval
	timer.connect("timeout", self, "on_timeout_complete")
	timer.start()
	add_child(timer)
	
	enemys = [
		preload("res://Enemys/Enemy.tscn"),
		preload("res://Enemys/Enemy_Red_Shooter.tscn")
	]
	
	enemyspawner1 = get_node("Enemy_Spawner1")
	enemyspawner2 = get_node("Enemy_Spawner2")
	
	item = preload("res://Environment/Item.tscn")
	spawn_item()


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
	r = floor(rand_range(0, 2))
	if r == 0:
		enemyspawner1.spawn_enemy(e)
	else:
		enemyspawner2.spawn_enemy(e)

func spawn_item():
	# get a random position
	# instance() the item
	# add item as child
	pass

func game_over():
	print("game over")