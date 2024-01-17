class_name Bullet
extends CharacterBody2D

@onready var visibile_notifier = $VisibileNotifier as VisibleOnScreenNotifier2D
@onready var death_timer = $DeathTimer as Timer	
@onready var sprite_2d = $Sprite2D as Sprite2D

var direction = Vector2.RIGHT
var speed:float = 0.0

func _physics_process(delta):
	move(delta)

func move(delta:float):
	move_and_collide(direction * speed * delta)
	

func _on_visibile_notifier_screen_exited():
	death_timer.start(0.8)


func _on_death_timer_timeout():
	queue_free()
