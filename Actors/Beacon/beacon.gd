class_name Beacon
extends Node2D

var player = Global.player
var bullet_types = Global.bullet_types
var moveable:bool = false

@export var color:Color = Color(1,1,1,0.25)
@export var weapon_type: int
@export var energy_needed:float = 50
@export var battery:float = 0
@onready var visible_shape = $beacon_halo/visibleShape

@onready var beacon_halo = $beacon_halo
@onready var halo_shape = $beacon_halo/haloShape
@onready var health_component = $HealthComponent
@onready var visible_on_screen_notifier_2d = $VisibleOnScreenNotifier2D

@onready var hitbox = $hitbox
@onready var powered: bool = false

# Called when the node enters the scene tree for the first time.s
func _ready():
	if Global.player:
		player = Global.player
	if Global.bullet_types:
		bullet_types = Global.bullet_types
		
	health_component.max_health = energy_needed
	health_component.current_health = battery
	beacon_halo.connect("body_entered", _on_halo_body_entered)
	beacon_halo.connect("body_exited", _on_halo_body_exited)
	hitbox.connect("area_entered", _on_hitbox_touched)
	hitbox.connect("area_exited", _on_hitbox_exited)
	visible_shape.color = color


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if powered:
		visible_shape.visible = true
		halo_shape.disabled = false
		
	else:
		visible_shape.visible = false
		halo_shape.disabled = true
	
	if Global.player:
		player = Global.player
		if moveable and Input.is_action_pressed("Move Beacon") and not player.holding_beacon:
			player.grab_beacon(self)
		if Input.is_action_just_released("Move Beacon"):
			player.drop_beacon()
		
		
func _physics_process(_delta):
	pass

func _on_halo_body_entered(body):
	if body.is_in_group("Player"):
		body.gunmod(weapon_type)
				
func _on_halo_body_exited(body):
	if body.is_in_group("Player"):
		body.gunmod(weapon_type)

func _on_hitbox_touched(area):
	#print("beacon entered by " + str(area))
	if area.is_in_group("Player"):
		var power_needed = health_component.max_health - health_component.current_health
		if Global.player:
			player = Global.player
			moveable = true;
			print("player touched a beacon")
			if player.spectral_energy > power_needed:
				player.spectral_energy -= power_needed
				health_component.gain_health(power_needed)
				powered = true;
			else:
				health_component.gain_health(player.spectral_energy)
				player.spectral_energy = 0
func _on_hitbox_exited(area):
	if area.is_in_group("Player"):
		moveable = false
