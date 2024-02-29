class_name EnemySpawner
extends Node2D

@onready var spawn_delay = $spawnDelay
@onready var spawn_location = $spawnLocation

@export var actor_to_spawn:PackedScene
@export var time_between_spawns:float
@export var quantity_per_spawn:int

func _ready():
	spawn_delay.connect("timeout", _on_spawn_delay_timeout)
	spawn_delay.wait_time = time_between_spawns
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_spawn_delay_timeout():
	var actor_container:Node = Global.get_actor_container()
	var enemyCount = get_tree().get_nodes_in_group("Enemies").size()
	print('there are ' + str(enemyCount) + ' enemies in the tree')
	if Global.enemy_limit > enemyCount:
		for n in quantity_per_spawn:
			var actor:Node2D = actor_to_spawn.instantiate()
			actor.position = spawn_location.global_position
			actor_container.add_child(actor)
