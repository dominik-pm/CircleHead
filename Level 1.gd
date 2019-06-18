extends Node2D

var enemys
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
	
	enemys = [
		preload("res://Enemy.tscn"),
		preload("res://Enemy_Red_Shooter.tscn")
	]
	
	enemyspawner1 = get_node("Enemy_Spawner1")
	enemyspawner2 = get_node("Enemy_Spawner2")


func spawn_enemy():
	var e
	e = enemys[1]
	
	var r = floor(rand_range(0, 2))
	if r == 0:
		enemyspawner1.spawn_enemy(e)
	else:
		enemyspawner2.spawn_enemy(e)
		
func game_over():
	print("game over")