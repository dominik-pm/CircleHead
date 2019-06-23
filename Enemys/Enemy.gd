extends RigidBody2D

export var health = 100
export var shield = 0
export var damage = 5
export var attacking_speed = 0.2

export var dampening = 6
export var speed = 12
var thrust = Vector2(0, 250*speed)
export var torque = 1000

var can_attack = true
var player
var dir
var vel

# Timer
var timer_attack = null

func _ready():
	set_linear_damp(dampening)
	
	player = get_parent().get_parent().get_node("Player").get_node("Character")
	
	# Timer
	timer_attack = Timer.new()
	timer_attack.wait_time = attacking_speed
	timer_attack.connect("timeout", self, "on_timeout_complete")
	add_child(timer_attack)
	timer_attack.start()
	
func _on_Enemy_body_entered(body):
	if body.is_in_group('player'):
		if can_attack: 
			# hit colliding player
			can_attack = false
			hit_player(body)
			timer_attack.start()

func _process(delta):
	pass
	# hit colliding player
	#var bodys = get_colliding_bodies()
	#for body in bodys:
		#if body.is_in_group('player'):
			#if can_attack: 
				#can_attack = false
				#hit_player(body)
				#timer_attack.start()

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

#func _on_Enemy_body_entered(body):
	#if body.is_in_group('bullet'):
		#print('enemy: bullet hit me!')
		#get_hit(body.damage)

func on_timeout_complete():
	can_attack = true

func hit_player(p):
	p.get_hit(damage)
