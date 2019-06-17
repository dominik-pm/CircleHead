extends RigidBody2D

export var health = 100
export var armor = 0
export var thrust = Vector2(0, 250)
export var torque = 1000

var player
var dir
var vel

func _ready():
	player = get_parent().get_node("Player")

func _process(delta):
	pass

func _integrate_forces(state):
	dir = player.position-self.position
	dir = dir.normalized()
	look_at(self.position+dir.rotated(PI/2)) # look at the player

	# set_applied_torque(-1or1 * torque) # would be better than just setting the direction
	
	# accellerate into rotation
	set_applied_force(-thrust.rotated(rotation))

func get_hit(dmg):
	health -= dmg
	if health <= 0:
		die()

func die():
	queue_free()

func _on_Enemy_body_entered(body):
	if body.is_in_group('bullet'):
		print('enemy: bullet hit me!')
		get_hit(body.damage)