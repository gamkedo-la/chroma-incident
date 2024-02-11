class_name Beacon
extends Node2D

var player = Global.player
var bullet_types = Global.bullet_types
@export var color:Color = Color(1,1,1,0.25)
@export var weapon_type: int
@export var energy_needed:float = 20
@export var battery:float = 0
@onready var visible_shape = $beacon_halo/visibleShape

@onready var beacon_halo = $beacon_halo
@onready var halo_shape = $beacon_halo/haloShape

@onready var hitbox = $hitbox
@onready var powered: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	beacon_halo.connect("body_entered", _on_halo_body_entered)
	beacon_halo.connect("body_exited", _on_halo_body_exited)
	hitbox.connect("area_entered", _on_hitbox_touched)
	visible_shape.color = color
	if Global.player:
		player = Global.player
	if Global.bullet_types:
		bullet_types = Global.bullet_types

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if powered:
		visible_shape.visible = true
		halo_shape.disabled = false
		
	else:
		visible_shape.visible = false
		halo_shape.disabled = true
		
		
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
		powered = true

