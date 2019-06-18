extends Node2D

var enemy

func _ready():
	enemy = preload("res://Enemy.tscn")

func spawn_enemy():
	var e = enemy.instance()
	e.position = self.position
	get_parent().add_child(e)