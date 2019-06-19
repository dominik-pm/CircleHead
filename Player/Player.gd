extends KinematicBody2D

export var max_health = 100
var health = max_health

export var max_shield = 100
var shield = max_shield
export var shield_reg = 1.25
export var shield_reg_interval = 1

export var movement_speed = 200
export var turn_speed = 0.03

var velocity = Vector2(0, 0)
var dir = Vector2(0, -1)
var this_pos

var current_gun = null
var current_gun_index = 0

# Shield Regeneration Timer
var timer_reg = null

var health_bar

func _ready():
	health_bar = get_parent().get_node("Player_Health_Bar")
	health_bar.init(max_health, max_shield)
	
	# Shield Regeneration Timer
	timer_reg = Timer.new()
	timer_reg.wait_time = shield_reg_interval
	timer_reg.connect("timeout", self, "shieldreg_on_timeout_complete")
	add_child(timer_reg)
	timer_reg.start()
	
	current_gun_index = 0
	change_gun(0)

#func _process(delta):
	#pass

# -- Timer called functions -->
# Regenerate shield
func shieldreg_on_timeout_complete():
	shield += shield_reg
	if shield > max_shield:
		shield = max_shield
		
	health_bar.change_health(health, shield)
	
	timer_reg.start()	
# <-- Timer called functions --

# handle input (change direction and velocity)
func get_input():
	# -- WEAPON SWITCH -->
	if Input.is_action_just_pressed("player_next_weapon"):
		change_gun(1)
	if Input.is_action_just_pressed("player_prev_weapon"):
		change_gun(-1)
	# <-- WEAPON SWITCH --
	
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
	current_gun.check_input(dir)
	look_at(this_pos+dir.rotated(PI/2)) # to rotate the player into the direction
	move_and_slide(velocity*movement_speed)
	
	## all in bullet now, delete if you are feeling like that :)
	#var collision = move_and_collide(delta*velocity*movement_speed)
	#if collision != null:
		#var body = collision.collider
		#if body.is_in_group('bullet'):
			#print('enemy: bullet hit me!')
			#get_hit(body.damage)
	##
	
	#move_and_slide(velocity*dir*movement_speed) # into the direction
	#self.position += velocity*dir*delta*movement_speed
	velocity = Vector2(0, 0)

# function to get hit by enemy
func get_hit(dmg):
	#print("player: got hit!")
	
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
		
func change_gun(i):
	# i is -1 or 1 (lower index or greater index)
	
	# get all guns from inventory
	var all_guns = get_node("Guns").get_children()
	
	# calculate index of the new gun
	var new_index = current_gun_index + i
	# if already at the last gun and player switches to higher index set index to first
	if new_index >= all_guns.size():
		new_index = 0
	# if already at the first gun and player switches to lower index set index to last
	if new_index < 0:
		new_index = all_guns.size()-1
	
	# set the current gun to the gun that should be changed to
	current_gun = all_guns[new_index]
	current_gun_index = new_index
	
	# hide all guns
	for gun in all_guns:
		gun.visible = false
	
	# display current gun
	current_gun.visible = true