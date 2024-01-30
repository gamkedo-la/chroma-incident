class_name ProjectileManager
extends Node2D

@onready var base_bullet_scene : PackedScene = preload("res://Actors/Bullet/Bullet.tscn")

func _ready():
	SignalBus.connect("fire", build_projectile)

func build_projectile(resource:ProjectileBase, location:Vector2, direction:Vector2, fired_by_enemy:bool) -> void:
	var new_bullet = base_bullet_scene.instantiate() as Bullet
	#this doesn't throw an error, but doesn't affect change
	new_bullet.sprite_texture = resource.projectile_texture
	new_bullet.position = location
	new_bullet.direction = (direction - global_position).normalized()
	new_bullet.rotation = new_bullet.direction.angle()
	new_bullet.speed = resource.projectile_speed
	spawn_projectile(new_bullet, fired_by_enemy)
	
func spawn_projectile(bullet:Bullet, fired_by_enemy:bool):
	if fired_by_enemy:
		# bullet.collision_layer = 0b00000000_00000000_00000000_00010000 #set to layer 5 for enemy bullets
		bullet.collision_mask = 0b00000000_00000000_00000000_00000111 #remove enemeies from mask, add player bullets
	var projectile_container = Global.get_projectile_container()
	if projectile_container == null:
				return
	projectile_container.add_child(bullet)
	
