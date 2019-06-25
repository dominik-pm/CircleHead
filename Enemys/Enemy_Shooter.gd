extends "res://Enemys/Enemy.gd"

export(PackedScene) var bullet

# override process
func _process(delta):
	pass

# override timout function to shoot instead of setting can_hit to true
func on_timeout_complete():
	shoot()
	timer_attack.start()

# override die function to spawn item when dead
func die():
	#get_parent().get_parent().spawn_item(self.position.x, self.position.y)
	queue_free()

# add this function
func shoot():
	#print("enemy: shooting!")
	var b = bullet.instance()
	var pos = $Gun/Muzzle.global_position
	b.init(pos, dir, damage)
	get_node("/root").add_child(b)