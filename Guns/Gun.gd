extends Node

export(AudioStreamSample) var sound_shoot
var bullet
export var damage = 50
export var shooting_speed = 0.2

# Timer
var timer_shoot = null
var can_shoot = true

func _ready():
	bullet = preload("res://Bullet/Bullet.tscn")
	
	# Shooting Timer
	timer_shoot = Timer.new()
	timer_shoot.wait_time = shooting_speed
	timer_shoot.connect("timeout", self, "shoot_on_timeout_complete")
	add_child(timer_shoot)

# set can_shoot to true after shot and after timer
func shoot_on_timeout_complete():
	can_shoot = true

func check_input(dir):
	if Input.is_action_pressed("player_shoot"):
		check_shoot(dir)

# function to shoot a bullet in the facing direction
func check_shoot(dir):
	if can_shoot:
		can_shoot = false
		timer_shoot.start()
		
		get_node("/root/SFX").play_sample(sound_shoot)
		shoot_bullet(dir)

func shoot_bullet(dir):
	var b = bullet.instance()
	var pos = $Muzzle.global_position
	b.init(pos, dir, damage)
	get_node("/root").add_child(b)