class_name BRG
extends CharacterBody2D

@onready var fire_timer = $Timer
@export var fire_rate: float = 0.5
@export var projectile_resource:ProjectileBase = null

var can_fire: bool = true

func _ready():
	fire_timer.connect("timeout", set_can_fire)
	fire_timer.wait_time = fire_rate
	
func _process(delta):
	look_at(get_global_mouse_position())
	fire_projectile()
	
func fire_projectile() -> void:
	if Input.is_action_pressed("shoot") and can_fire:
		can_fire = false
		fire_timer.start()
		print("BANG")
		SignalBus.emit_fire(projectile_resource, global_position,
			(get_global_mouse_position() - global_position).normalized())

func set_can_fire() -> void:
	can_fire = true