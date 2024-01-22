extends Node2D

var player = Global.player
var bullet_types = Global.bullet_types
@export var color:Color = Color(1,1,1,0.25)
@export var weapon_type: int
@onready var area_shape = $areaShape

# Called when the node enters the scene tree for the first time.
func _ready():
	area_shape.color = color
	if Global.player:
		player = Global.player
	if Global.bullet_types:
		bullet_types = Global.bullet_types

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_area_2d_body_entered(body):
	if body.has_method('gunswap'):
		body.gunswap(weapon_type)
		
func _on_area_2d_body_exited(body):
	if body.has_method('gunswap'):
		body.gunswap(0)

