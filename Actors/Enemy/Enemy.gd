extends CharacterBody2D

@export var max_speed = 50
@export var min_speed = 10
@export var health = 30

var alive:bool = true

@onready var animation_player = $AnimationPlayer

var target = Global.player

@onready var navigation_agent: NavigationAgent2D = $Navigation/NavigationAgent2D
@onready var shoot_timer = $shootTimer
@onready var child_node_health = $Health

@export var fire_rate_per_second:float = 4

func _ready():
	# Connect the health component signal for health to our handler in enemy
	child_node_health.healthReachedMinimum.connect(_on_healthReachedMinimum)
	shoot_timer.connect("timeout", _on_shoot_timer_timeout)
	shoot_timer.wait_time = 1/fire_rate_per_second

	if Global.player:
		target = Global.player

func _on_healthReachedMinimum():
	alive = false
	animation_player.play("die")

func _physics_process(_delta):
	var direction = Vector2.ZERO
	direction = navigation_agent.get_next_path_position() - global_position
	var distance = global_position.distance_to(target.global_position)
	direction = direction.normalized()
	velocity = direction * max(min_speed, max_speed * (distance / 100))
	
	#look_at(target.global_position)
	if alive:
		move_and_slide()
	
func _on_timer_timeout():
	navigation_agent.target_position = target.global_position

func _on_shoot_timer_timeout():
	shoot()

func handle_hit():
	$Health.take_damage(5)
	
func shoot():
	shoot_timer.start()
	var projectile_resource:ProjectileBase = Global.bullet_types[1]
	SignalBus.emit_fire(projectile_resource, global_position,
		(target.global_position - global_position).normalized(), true)
	



