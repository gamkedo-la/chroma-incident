extends CharacterBody2D

@export var max_speed = 100
@export var min_speed = 10

@onready var player:Node2D = get_node("/root/main/Player")

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	var distance = global_position.distance_to(player.global_position)
	velocity = direction * max(min_speed, max_speed * (distance / 100))
	look_at(player.global_position)
	move_and_slide()
