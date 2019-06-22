extends Node2D

var animation

# when the item is in the game
func _ready():
	animation = get_node("item/AnimationPlayer")
	
	# play appearing animation
	animation.play("spawn")
	
	# connect the animation_finished signal
	animation.connect("animation_finished", self, "on_animation_finished")

func init(x, y):
	# set position
	self.position = Vector2(x, y)

func _on_Area2D_body_entered(body):
	if body.is_in_group('player'):
		body.on_item_got_item()
		
		# play disappearing animation
		animation.play("despawn")

func on_animation_finished(finished_anim):
	# check if the finished_anim is spawn, then set the animation to idle
	if finished_anim == "spawn":
		animation.play("idle")

	# check if the finished_anim is despawn, then delete this item
	if finished_anim == "despawn":
		print("item: player got me!")
		queue_free()