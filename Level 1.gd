extends Node2D

var enemy
var enemyspawner1
var enemyspawner2

# Timer
var timer
var spawn_interval = 3

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
	
	enemy = preload("res://Enemy.tscn")
	
	enemyspawner1 = get_node("Enemy_Spawner1")
	enemyspawner2 = get_node("Enemy_Spawner2")

#func _process(delta):
#	pass

func spawn_enemy():
	var r = floor(rand_range(0, 2))
	if r == 0:
		enemyspawner1.spawn_enemy(1)
	else:
		enemyspawner2.spawn_enemy(2)
		
func game_over():
	print("game over")