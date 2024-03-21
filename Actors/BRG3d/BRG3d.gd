class_name BRG
extends CharacterBody3D


@export var fire_rate: float = 0.2
@export var beaconEffects:int = 0
@export var projectile_resource:ProjectileBase = null

@onready var fire_timer = $Timer
@onready var bullet_emit = $bulletEmit


var can_fire: bool = true
var bullet_types: Array[ProjectileBase]

func _ready():
	if Global.bullet_types:
		bullet_types = Global.bullet_types
		
	SignalBus.connect("gunmod", gunmod)
	fire_timer.connect("timeout", set_can_fire)
	fire_timer.wait_time = fire_rate
	
func _process(_delta):
	#TODO generalize mouse raycast and put in global for things that need to get 3d mouse pos
	
	look_at(Global.get_mouse_position())
	fire_projectile()
	
func gunmod(effectType:int) -> void:
	beaconEffects = beaconEffects ^ effectType
	self.projectile_resource = bullet_types[beaconEffects]
	
func fire_projectile() -> void:
	if Input.is_action_pressed("shoot") and can_fire:
		can_fire = false
		fire_timer.start()
		SignalBus.emit_fire(projectile_resource, bullet_emit.global_position,
			(Global.get_mouse_position() - global_position).normalized(), false)

func set_can_fire() -> void:
	can_fire = true


		
