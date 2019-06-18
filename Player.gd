extends KinematicBody2D

export var max_health = 100
var health = max_health
export var max_shield = 100
var shield = max_shield
export var shield_reg = 1.25
export var shield_reg_interval = 1
export var armor = 0
export var shooting_speed = 0.4
export var movement_speed = 200
export var turn_speed = 0.03
var velocity = Vector2(0, 0)
var dir = Vector2(0, -1)
var this_pos

# Shield Regeneration Timer
var reg_timer = null

# Shooting Timer
var timer = null
var can_shoot = true

var bullet
var health_bar

func _ready():
	bullet = preload("res://Bullet.tscn")
	health_bar = get_parent().get_node("Player_Health_Bar")
	health_bar.init(max_health, max_shield)
	
	# Shooting Timer
	timer = Timer.new()
	timer.wait_time = shooting_speed
	timer.connect("timeout", self, "shoot_on_timeout_complete")
	add_child(timer)
	timer.start()
	
	# Shield Regeneration Timer
	reg_timer = Timer.new()
	reg_timer.wait_time = shield_reg_interval
	reg_timer.connect("timeout", self, "shieldreg_on_timeout_complete")
	add_child(reg_timer)
	reg_timer.start()

#func _process(delta):
	#pass

# handle input (change direction and velocity)
func get_input():
	# -- SHOOT --
	if Input.is_action_pressed("player_shoot"):
		shoot()
	
	# -- VELOCITY --
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
		
	# -- DIRECTION --
	# rotate with keyboard
	#if Input.is_action_pressed('ui_right'):
		#dir = dir.rotated(turn_speed)
	#if Input.is_action_pressed('ui_left'):
		#dir = dir.rotated(-turn_speed)
		
	# -- DIRECTION --	
	var mouse_pos = get_global_mouse_position() # get the mouse position as a 2Dvector
	
	# set the direction into the direction of the mouse
	this_pos = self.position # vector at the players location
	dir = mouse_pos-this_pos  # calculate a vector that is pointing from the player to the mouse
	dir = dir.normalized() # make a unit vector

func _physics_process(delta):
	get_input()
	look_at(this_pos+dir.rotated(PI/2)) # to rotate the player into the direction
	move_and_slide(velocity*movement_speed)
	#move_and_slide(velocity*dir*movement_speed) # into the direction
	#self.position += velocity*dir*delta*movement_speed
	velocity = Vector2(0, 0)

# set can_shoot to true after shot and after timer
func shoot_on_timeout_complete():
	can_shoot = true

# function to shoot a bullet in the facing direction
func shoot():
	if can_shoot:
		can_shoot = false
		timer.start()
		
		# add a bullet to the game the bullet
		var b = bullet.instance()
		b.init(this_pos, dir)
		get_parent().add_child(b)

# Regenerate shield
func shieldreg_on_timeout_complete():
	shield += shield_reg
	if shield > max_shield:
		shield = max_shield
		
	health_bar.change_health(health, shield)
	
	reg_timer.start()

# function to get hit by enemy
func get_hit(dmg):
	print("player: got hit!")
	
	if shield >= dmg:
		shield -= dmg
	elif shield < dmg:
		var d = dmg - shield
		shield = 0
		
		if d > health:
			health = 0
		else:
			health -= d
	
	health_bar.change_health(health, shield)
	
	if health <= 0:
		get_parent().game_over()