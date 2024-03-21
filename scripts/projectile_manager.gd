class_name ProjectileManager
extends Node3D

@onready var base_bullet_scene : PackedScene = preload("res://Actors/Bullet3d/Bullet.tscn")
@onready var base_spectral_drop_scene : PackedScene = preload("res://Actors/SpectralEnergyDrop/SpectralEnergyDrop.tscn")
func _ready():
	SignalBus.connect("fire", build_projectile)
	SignalBus.connect("spawn_energy_drops", spawn_energy_drops)
	
func build_projectile(resource:ProjectileBase, location:Vector3, direction:Vector3, fired_by_enemy:bool) -> void:
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
		bullet.collision_layer = 0b00000000_00000000_00000000_00010000 #set to layer 5 for enemy bullets
		bullet.collision_mask = 0b00000000_00000000_00000000_00010111
	
	 #remove enemeies from mask, add other bullets
	var projectile_container = Global.get_projectile_container()
	if projectile_container == null:
				return
	projectile_container.call_deferred("add_child", bullet)
	
func spawn_energy_drops(value:int, amount:int, location:Vector3):
	for n in amount:
		var drop:Node3D = base_spectral_drop_scene.instantiate()
		drop.position = location + Vector3(randf_range(-10, 10), 0.1, randf_range(-10, 10))
		drop.energy_value = value
		var container = Global.get_projectile_container()
		if container == null:
			return
		container.call_deferred("add_child", drop)
		
		
