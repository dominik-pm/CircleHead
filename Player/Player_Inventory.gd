extends Node2D

var gun_sprites
var slots

func _ready():
	pass

func init():
	gun_sprites = get_parent().gun_sprites
	
	slots = $inventory.get_children()

func add_gun(index):
	slots[index].set_icon(gun_sprites[index])	

func select_slot(index):
	# deselect alll slots
	for i in range(slots.size()):
		if slots[i].gun_set:
			slots[i].deselect()
	
	# select given slot
	slots[index].select()