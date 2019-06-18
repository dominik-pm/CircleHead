extends Node2D

var enemy1
var enemy2

func _ready():
	enemy1 = preload("res://Enemy.tscn")
	enemy2 = preload("res://Enemy.tscn")

func spawn_enemy(i):
	var enemy
	
	if i == 0:
		enemy = enemy1.instance()
	elif i == 1:
		enemy = enemy1.instance()
	elif i == 2:
		enemy = enemy2.instance()
	
	enemy.position = self.position
	get_parent().add_child(enemy)