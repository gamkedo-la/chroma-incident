class_name Enemy2
extends CharacterBody2D

@export var max_speed:int = 100
@export var min_speed:int = 40
@export var health:int = 1
@export var energy_value:int =  1

var alive:bool = true

@onready var animation_player = $AnimationPlayer

var target = Global.player

@onready var navigation_agent: NavigationAgent2D = $Navigation/NavigationAgent2D
@onready var shoot_timer = $shootTimer
@onready var child_node_health = $Health

@export var fire_rate_per_second:float = 0

func _ready():
	add_to_group("Enemies")
	child_node_health.current_health = health
	child_node_health.max_health = health
	# Connect the health component signal for health to our handler in enemy
	child_node_health.healthReachedMinimum.connect(_on_healthReachedMinimum)
	shoot_timer.connect("timeout", _on_shoot_timer_timeout)
	shoot_timer.wait_time = 1/fire_rate_per_second

	if Global.player:
		target = Global.player

func _on_healthReachedMinimum():
	alive = false
	animation_player.play("die")
	SignalBus.emit_spawn_energy_drops(energy_value, 5, global_position)

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
	pass

func handle_hit():
	$Health.take_damage(5)
	SignalBus.emit_spawn_energy_drops(energy_value, 1, global_position)
func shoot():
	shoot_timer.start()
	var projectile_resource:ProjectileBase = Global.bullet_types[1]
	SignalBus.emit_fire(projectile_resource, global_position,
		(target.global_position - global_position).normalized(), true)
	



