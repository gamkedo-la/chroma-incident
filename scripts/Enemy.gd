extends CharacterBody2D

@export var max_speed = 100
@export var min_speed = 10

var target = Global.player
@onready var navigation_agent: NavigationAgent2D = $Navigation/NavigationAgent2D

func _physics_process(_delta):
	if target:
		var direction = Vector2.ZERO
		direction = navigation_agent.get_next_path_position() - global_position
		var distance = global_position.distance_to(target.global_position)
		direction = direction.normalized()
		velocity = direction * max(min_speed, max_speed * (distance / 100))
		
		look_at(target.global_position)
		move_and_slide()


func _on_timer_timeout():
	if target:
		navigation_agent.target_position = target.global_position
