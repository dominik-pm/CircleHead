extends "res://Bullet/Bullet.gd"

export var freeze_time = 0.5

# override the colliding function to add the freeze
func _on_Bullet_body_entered(body):
	if body.is_in_group('enemy') or body.is_in_group('player'):
		body.get_hit(damage)
		if body.has_method('freeze'):
			body.freeze(freeze_time)
	queue_free()