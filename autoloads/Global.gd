extends Node

const PROJECTILE_CONTAINER_PATH = "/root/main/Projectiles"
const ACTOR_CONTAINER_PATH = "/root/main/Actors"
var player:CharacterBody2D

@export var bullet_types:Array[ProjectileBase] = []

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

func get_projectile_container() -> Node2D:
	return get_node(PROJECTILE_CONTAINER_PATH)

func get_actor_container() -> Node2D:
	return get_node(ACTOR_CONTAINER_PATH)
	
func register_player(in_player):
	player = in_player
