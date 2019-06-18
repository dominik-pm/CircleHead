extends Node2D

var health_bar
var shield_bar

func init(max_health, max_shield):
	health_bar = get_node("HealthBar")
	health_bar.max_value = max_health
	health_bar.value = health_bar.max_value
	
	shield_bar = get_node("ShieldBar")
	shield_bar.max_value = max_shield
	shield_bar.value = shield_bar.max_value

func change_health(health, shield):
	health_bar.value = health
	shield_bar.value = shield