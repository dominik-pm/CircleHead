extends Node2D

func init(x, y):
	# set position
	self.position = Vector2(x, y)
	
	# play appearing animation
	get_node("item/AnimationPlayer").play("spawn")
	
	# connect de animation_finished signal
	get_node("item/AnimationPlayer").connect("animation_finished", self, "on_animation_finished")

func _on_Area2D_body_entered(body):
	if body.is_in_group('player'):
		body.on_item_got_item()
		
		# play disappearing animation
		get_node("item/AnimationPlayer").play("despawn")

func on_animation_finished(finished_anim):
	# check if the finished_anim is spawn, set animation to idle
	if finished_anim == "spawn":
		get_node("item/AnimationPlayer").play("idle")

	# check if the finished_anim is despawn, then delete this item
	if finished_anim == "despawn":
		print("item: player got me!")
		queue_free()