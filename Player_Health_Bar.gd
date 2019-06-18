extends Node2D

var bar

func init(max_health):
	bar = get_node("ProgressBar")
	bar.max_value = max_health
	bar.value = bar.max_value

func lose_health(dmg):
	bar.value -= dmg
	if bar.value < 0:
		bar.value = 0