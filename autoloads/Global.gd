extends Node

const PROJECTILE_CONTAINER_PATH = "/root/main/Projectile_Container"

var player:CharacterBody2D

func get_projectile_container() -> Node2D:
	return get_node(PROJECTILE_CONTAINER_PATH)

func register_player(in_player):
	player = in_player
