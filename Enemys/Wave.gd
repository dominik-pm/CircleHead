extends Node2D

export (Array, PackedScene) var enemys
export (Array, int) var enemy_counts

signal spawn_enemy
signal wave_complete

var enemys_to_spawn = []

var timer
export (float) var spawn_interval = 1

func _ready():
	# catch error (or find a better way of doing this)
	if enemys.size() != enemy_counts.size():
		print("wave: error, not the same amount of enemys and counts")
		get_tree().quit()
	# initialize the enemys_to_spawn array
	for i in range(enemys.size()):
		for j in range(enemy_counts[i]):
			enemys_to_spawn.append(enemys[i])
	
	# Timer initializing
	timer = Timer.new()
	timer.wait_time = spawn_interval
	timer.connect("timeout", self, "on_timeout_complete")
	add_child(timer)
	
	# connect signals to the level
	var level = get_parent().get_parent()
	self.connect("spawn_enemy", level, "on_wave_spawn_enemy")
	self.connect("wave_complete", level, "on_wave_complete")

func start_wave():
	timer.start()
	
func on_timeout_complete():
	spawn_sequence()
	
func spawn_sequence():
	if enemys_to_spawn.size() >= 1:
		var e = enemys_to_spawn[0]
		enemys_to_spawn.pop_front()
		emit_signal("spawn_enemy", e)
	else:
		emit_signal("wave_complete", self)

func spawn_random():
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
		
	emit_signal("spawn_enemy", e)