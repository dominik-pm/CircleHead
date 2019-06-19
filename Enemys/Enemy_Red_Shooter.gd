extends "res://Enemys/Enemy.gd"

var bullet

func _ready():
	bullet = preload("res://Bullet/Bullet_Fireball.tscn")
	._ready()
	
func _process(delta):
	pass

# override timout function to shoot instead of setting can_hit to true
func on_timeout_complete():
	shoot()
	timer.start()

# add this function
func shoot():
	#print("enemy: shooting!")
	var b = bullet.instance()
	var pos = $Gun/Muzzle.global_position
	b.init(pos, dir, damage)
	get_node("/root").add_child(b)