extends KinematicBody2D

export var health = 100
export var armor = 0
export var shooting_speed = 0.2
export var movement_speed = 200
export var turn_speed = 0.03
var velocity = Vector2(0, 0)
var dir = Vector2(0, -1)
var this_pos

# Timer
var timer = null
var can_shoot = true

var bullet
var health_bar

func _ready():
	bullet = preload("res://Bullet.tscn")
	health_bar = get_parent().get_node("Player_Health_Bar")
	health_bar.init(health)
	
	# Timer
	timer = Timer.new()
	timer.wait_time = shooting_speed
	timer.connect("timeout", self, "on_timeout_complete")
	add_child(timer)
	timer.start()

func on_timeout_complete():
	can_shoot = true

func _process(delta):
	if Input.is_action_pressed("player_shoot"):
		shoot()
		
	# calculate direction
	this_pos = self.position # vector at the players location
	var mouse_pos = get_global_mouse_position() # vector at the mouse position
	
	# rotate with mouse
	dir = mouse_pos-this_pos  # calculate a vector that is pointing from the player to the mouse
	dir = dir.normalized() # make a unit vector
	
	look_at(this_pos+dir.rotated(PI/2)) # to rotate the player into the direction

func get_input():
	if Input.is_action_pressed('ui_up'):
		velocity.y = -1
	if Input.is_action_pressed('ui_down'):
		velocity.y = 1
	if Input.is_action_pressed('ui_right'):
		velocity.x = 1
	if Input.is_action_pressed('ui_left'):
		velocity.x = -1
		
	# just moving forward and backwards
	#if Input.is_action_pressed('ui_up'):
		#velocity = 1
	#if Input.is_action_pressed('ui_down'):
		#velocity = -1
		
	# rotate with keyboard
	#if Input.is_action_pressed('ui_right'):
		#dir = dir.rotated(turn_speed)
	#if Input.is_action_pressed('ui_left'):
		#dir = dir.rotated(-turn_speed)

func _physics_process(delta):
	get_input()
	move_and_slide(velocity*movement_speed)
	#move_and_slide(velocity*dir*movement_speed) # into the direction
	#self.position += velocity*dir*delta*movement_speed
	velocity = Vector2(0, 0)

func shoot():
	if can_shoot:
		can_shoot = false
		timer.start()
		
		# add a bullet to the game the bullet
		var b = bullet.instance()
		b.init(this_pos, dir)
		get_parent().add_child(b)
		
func get_hit(dmg):
	print("player: got hit!")
	
	health -= dmg
	if health <= 0:
		get_parent().game_over()
		
	health_bar.lose_health(dmg)