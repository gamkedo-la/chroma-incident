extends Node

const PROJECTILE_CONTAINER_PATH = "/root/main/Projectile_Container"

var player:CharacterBody2D

@export var bullet_types:Array[ProjectileBase] = []

func get_projectile_container() -> Node2D:
	return get_node(PROJECTILE_CONTAINER_PATH)

func register_player(in_player):
	player = in_player

