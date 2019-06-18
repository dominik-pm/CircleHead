extends Node2D

func spawn_enemy(enemy):
	var e = enemy.instance()
	e.position = self.position
	get_parent().add_child(e)