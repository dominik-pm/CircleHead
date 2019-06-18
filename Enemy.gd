extends RigidBody2D

export var health = 100
export var armor = 0
export var thrust = Vector2(0, 250)
export var torque = 1000
export var damage = 1
export var hitting_speed = 0.2

var can_hit = true
var player
var dir
var vel

# Timer
var timer = null

func _ready():
	# Timer
	timer = Timer.new()
	timer.wait_time = hitting_speed
	timer.connect("timeout", self, "on_timeout_complete")
	add_child(timer)
	
	player = get_parent().get_node("Player")
	
func _process(delta):
	var bodys = get_colliding_bodies()
	for body in bodys:
		if body.is_in_group('player'):
			if can_hit: 
				can_hit = false
				hit_player(body)
				timer.start()

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

func on_timeout_complete():
	can_hit = true

func hit_player(p):
	p.get_hit(damage)