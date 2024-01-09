extends CharacterBody2D

@export var max_speed = 100
@export var min_speed = 10

@export var player:Node2D
@onready var navigation_agent: NavigationAgent2D = $Navigation/NavigationAgent2D

func _physics_process(delta):
	#var direction = global_position.direction_to(player.global_position)
	var direction = Vector2.ZERO
	direction = navigation_agent.get_next_path_position() - global_position
	var distance = global_position.distance_to(player.global_position)
	direction = direction.normalized()
	velocity = direction * max(min_speed, max_speed * (distance / 100))
	
	look_at(player.global_position)
	move_and_slide()


func _on_timer_timeout():
	navigation_agent.target_position = player.global_position
