class_name Bullet
extends Area3D

@onready var visibile_notifier = $VisibileNotifier as VisibleOnScreenNotifier2D
@onready var death_timer = $DeathTimer as Timer	
@onready var sprite_texture = $Sprite2D.texture as Texture:
							set = _set_texture
var sparks:PackedScene = preload("res://scenes/particles/splode.tscn")
							
func _ready():
	connect("area_entered", _on_area_entered)
	connect("body_entered", _on_body_entered)

func _set_texture(value):
	# If the texture variable is modified externally,
	# this callback is called.
	sprite_texture = value  # Texture was changed.
	$Sprite2D.set_texture(value) # tell godot to adjust the sprite
	#queue_redraw()  # Trigger a redraw of the node.

var direction = Vector2.RIGHT
var speed:float = 0.0

func _physics_process(delta):
	move(delta)

func move(delta:float):
	#var collision = move_and_collide(direction * speed * delta)
	translate(direction * speed * delta)
		

func _on_visibile_notifier_screen_exited():
	death_timer.start(0.8)


func _on_death_timer_timeout():
	queue_free()

func handle_hit():
	sparks.emitting = true
	queue_free()

func _on_Bullet_body_entered(body:Node):
	if body.has_method("handle_hit"):
		body.handle_hit()
		
		queue_free()


func _on_body_entered(body):
	if body.has_method("handle_hit"):
		body.handle_hit()
# TODO create new particle effects with 3D particles
	queue_free()
		
func _on_area_entered(area:Area2D):
	var body = area.get_parent();
	if body.has_method("handle_hit"):
		body.handle_hit()
		queue_free()

