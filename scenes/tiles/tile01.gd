extends Node2D
@onready var color_rect_2 = $ColorRect2
@onready var color_rect_3 = $ColorRect3


# Called when the node enters the scene tree for the first time.
func _ready():
	color_rect_2.position += Vector2(randf_range(-2, 2), randf_range(-2,2))
	color_rect_3.position += Vector2(randf_range(-2, 2), randf_range(-2,2))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
