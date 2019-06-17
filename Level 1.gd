extends Node2D

var enemy

# Timer
var timer
var spawn_interval = 5

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

#func _process(delta):
#	pass

func spawn_enemy():
	var e = enemy.instance()
	e.position = Vector2(950, 50)
	add_child(e)