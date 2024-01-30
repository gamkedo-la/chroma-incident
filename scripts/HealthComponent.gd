extends Node

var current_health : int = 100
var max_health : int = 100
var min_health : int = 0

signal healthReachedMinimum()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func take_damage(damage: int):
	current_health -= damage
	current_health = max(current_health, min_health)
	if (current_health == min_health):
		emit_signal("healthReachedMinimum")
