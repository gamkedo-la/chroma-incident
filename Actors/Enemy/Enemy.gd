class_name Enemy
extends CharacterBody2D

@export var max_speed:int = 50
@export var min_speed:int = 10
@export var health:int = 20
@export var energy_value:int =  1
@export var fire_rate_per_second:float = 4

var target = Global.player
var alive:bool = true
var direction:Vector2 = Vector2.ZERO
@onready var navigation_agent: NavigationAgent2D = $Navigation/NavigationAgent2D
@onready var shoot_timer = $shootTimer
@onready var child_node_health = $Health
@onready var enemy_graphic = $EnemyGraphic
@onready var animation_player = $AnimationPlayer
@onready var can_fire_visual_notifier = $CanFireVisualNotifier
@onready var can_move_visual_notifier = $CanMoveVisualNotifier


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
	if not can_move_visual_notifier.is_on_screen():
		return
	direction = navigation_agent.get_next_path_position() - global_position
	var distance = global_position.distance_to(target.global_position)
	direction = direction.normalized()
	velocity = direction * max(min_speed, max_speed * (distance / 100))
	
	#look_at(target.global_position)
	if alive:
		move_and_slide()
		
func _process(_delta):
	var graphic_parts = enemy_graphic.get_children()
	for part in graphic_parts:
		part.rotation = atan2(direction.y, direction.x) - PI/2
	
func _on_timer_timeout():
	navigation_agent.target_position = target.global_position

func _on_shoot_timer_timeout():
	if can_fire_visual_notifier.is_on_screen():
		shoot()

func handle_hit():
	$Health.take_damage(5)
	SignalBus.emit_spawn_energy_drops(energy_value, 1, global_position)
	
func shoot():
	shoot_timer.start()
	var projectile_resource:ProjectileBase = Global.bullet_types[1]
	SignalBus.emit_fire(projectile_resource, global_position,
		(target.global_position - global_position).normalized(), true)
	



