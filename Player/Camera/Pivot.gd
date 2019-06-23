extends Position2D

onready var parent = get_parent()

func _ready():
	pass
	
func _physics_process(delta):
	update_pivot_angle()
	
func update_pivot_angle():
	#rotation = parent.dir.angle()
	#rotation = parent.velocity.angle() # DOES STILL ROTATE WITH MOUSE WTF
	pass