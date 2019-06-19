extends RigidBody2D

export var speed = 500
var damage = 0
var dir = Vector2(0, 0)

func _ready():
	pass # Replace with function body.

# to set it's starting position and direction
func init(pos, d, dmg):
	self.position = Vector2(pos.x, pos.y)
	dir.x = d.x
	dir.y = d.y
	damage = dmg

func _process(delta):
	# move into the direction with the given speed
	self.position.x += speed * delta * dir.x
	self.position.y += speed * delta * dir.y
	
	# if the bullet is not in the viewport
	if not get_node("VisibilityNotifier2D").is_on_screen():
		queue_free()
		#pass

# if the bullet collides with something
func _on_Bullet_body_entered(body):
	if body.is_in_group('enemy') or body.is_in_group('player'):
		body.get_hit(damage)
	queue_free()