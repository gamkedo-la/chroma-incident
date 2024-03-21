extends Node3D

const PROJECTILE_CONTAINER_PATH = "/root/main3d/Projectiles"
const ACTOR_CONTAINER_PATH = "/root/main3d/Actors"

var player:CharacterBody3D
var camera:Camera3D

@export var bullet_types:Array[ProjectileBase] = []
@export var enemy_limit:int = 40

const BLACK:int = 0
const RED:int = 1
const YELLOW:int = 2
const BLUE:int = 4
#0000 0001 = red
#0000 0010 = yellow
#0000 0011 = orange
const ORANGE:int = 3
#0000 0010 = yellow
#0000 0100 = blue
#0000 0110 = green
const GREEN:int = 6
#0000 0100 = blue
#0000 0001 = red
#0000 0101 = purple
const PURPLE:int = 5

func get_projectile_container() -> Node3D:
	return get_node(PROJECTILE_CONTAINER_PATH)

func get_actor_container() -> Node3D:
	return get_node(ACTOR_CONTAINER_PATH)
	
func register_player(in_player):
	player = in_player
	camera = in_player.camera

func get_mouse_position() -> Vector3:
	var mouse_position = get_viewport().get_mouse_position()
	var space_state = get_world_3d().direct_space_state
	var from = camera.project_ray_origin(mouse_position)
	var to = from + camera.project_ray_normal(mouse_position) * 3000
	var ray_query = PhysicsRayQueryParameters3D.create(from, to)
	var intersection = space_state.intersect_ray(ray_query)
	if not intersection.is_empty():
		return intersection.position
	return Vector3.ZERO
