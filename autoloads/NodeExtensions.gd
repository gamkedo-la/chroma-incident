extends Node

const PROJECTILE_CONTAINER_PATH = "/root/main/Projectile_Container"

func get_projectile_container() -> Node2D:
	return get_node(PROJECTILE_CONTAINER_PATH)
