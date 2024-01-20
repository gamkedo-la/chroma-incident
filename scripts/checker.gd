@tool
class_name Checkerboard
extends Node2D

# Customize these variables as needed
@export var square_size := 64
@export var board_width := 8
@export var board_height := 8
@export var color_1:Color = Color(1,1,1)
@export var color_2:Color = Color(0,0,0)

func _ready():
	queue_redraw()
	
func _process(_delta):
	queue_redraw()
	
func _draw():
	for x in range(board_width):
		for y in range(board_height):
		# Determine the color of the square based on its position
			var color := color_1 if (x + y) % 2 == 0 else color_2
			# Calculate the position of the square
			var draw_position := Vector2(x * square_size, y * square_size)
			# Draw the square
			draw_rect(Rect2(draw_position, Vector2(square_size, square_size)), color)
