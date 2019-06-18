extends RigidBody2D

export var health = 100
export var shield = 0
export var damage = 1
export var hitting_speed = 0.2
export var is_shooter = false

export var dampening = 6
export var speed = 12
var thrust = Vector2(0, 250*speed)
export var torque = 1000

var can_hit = true
var player
var bullet
var dir
var vel

# Timer
var timer = null

func _ready():
	set_linear_damp(dampening)
	
	player = get_parent().get_node("Player")
	bullet = preload("res://Bullet_Enemy.tscn")
	
	# Timer
	timer = Timer.new()
	timer.wait_time = hitting_speed
	timer.connect("timeout", self, "on_timeout_complete")
	add_child(timer)
	timer.start()
	
func _process(delta):
	# if this enemy doesn't shoot, hit colliding player
	if !is_shooter:
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
	if shield >= dmg:
		shield -= dmg
	elif shield < dmg:
		var d = dmg - shield
		shield = 0
		
		if d > health:
			health = 0
		else:
			health -= d
	
	if health <= 0:
		die()

func die():
	queue_free()

func _on_Enemy_body_entered(body):
	if body.is_in_group('bullet'):
		print('enemy: bullet hit me!')
		get_hit(body.damage)

func on_timeout_complete():
	if is_shooter:
		shoot()
		timer.start()
	else:
		can_hit = true

func hit_player(p):
	p.get_hit(damage)
	
func shoot():
	print("enemy: shooting!")
	var b = bullet.instance()
	b.init(self.position, dir)
	get_parent().add_child(b)