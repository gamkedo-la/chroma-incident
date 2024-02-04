extends Node

var current_health : float = 100
var max_health : float = 100
var min_health : float = 0

signal healthReachedMinimum()

@onready var health_bar = $"../HealthBar"
# Called when the node enters the scene tree for the first time.
func _ready():
	var percent_health = (current_health / max_health) * 100
	health_bar.value = percent_health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func take_damage(damage: int) -> void:
	var percent_health = (current_health / max_health) * 100
	print("Previous health: %d%, %f" % [current_health, percent_health])
	current_health -= damage
	current_health = max(current_health, min_health)
	if (current_health == min_health):
		emit_signal("healthReachedMinimum")
	percent_health = (current_health / max_health) * 100
	health_bar.value = percent_health
	print("New health: %d%% , %f" % [current_health, percent_health])
		
func is_alive() -> bool:
	return current_health > min_health
