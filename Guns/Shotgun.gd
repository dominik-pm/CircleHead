extends "res://Guns/Gun.gd"

# new variable for the angle in between the bullets
export var angle = 10

# override this function to shoot 3 bullets
func shoot_bullet(dir):
	var b1 = bullet.instance()
	var b2 = bullet.instance()
	var b3 = bullet.instance()
	var pos = $Muzzle.global_position
	b1.init(pos, dir, damage)
	b2.init(pos, dir.rotated(deg2rad(-angle)), damage)
	b3.init(pos, dir.rotated(deg2rad(angle)), damage)
	get_node("/root").add_child(b1)
	get_node("/root").add_child(b2)
	get_node("/root").add_child(b3)