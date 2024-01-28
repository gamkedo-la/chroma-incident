extends CharacterBody2D

@export var max_speed = 100
@export var min_speed = 10
@export var health = 100

var alive:bool = true

@onready var animation_player = $AnimationPlayer

var target = Global.player
@onready var navigation_agent: NavigationAgent2D = $Navigation/NavigationAgent2D

var fire_rate_per_second: int = 4

func _ready():
	var child_node_health = get_node('Health')  # Connect to our health component
	# Connect the health component signal for health to our handler in enemy
	child_node_health.healthReachedMinimum.connect(_on_healthReachedMinimum)

	if Global.player:
		target = Global.player

func _on_healthReachedMinimum():
	alive = false
	print("Enemy's been killed")
	animation_player.play("die")

func _physics_process(_delta):
	var direction = Vector2.ZERO
	direction = navigation_agent.get_next_path_position() - global_position
	var distance = global_position.distance_to(target.global_position)
	direction = direction.normalized()
	velocity = direction * max(min_speed, max_speed * (distance / 100))
	
	look_at(target.global_position)
	if alive:
		move_and_slide()
	var projectile_resource:ProjectileBase = Global.bullet_types[0]
	SignalBus.emit_fire(projectile_resource, global_position,
		(target.global_position))

func _on_timer_timeout():
	navigation_agent.target_position = target.global_position

func handle_hit():
	$Health.take_damage(5)
	
	
