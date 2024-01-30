extends CharacterBody2D

@export var move_speed = 100
@export var drag = 0.85
@export var rotation_speed = 0.3


var move_vector:Vector2 
var aim_vector:Vector2
var rotation_target:float 
var accelleration:Vector2
var mouse_in_use:bool = true

func _ready():
	Global.register_player(self)

func _physics_process(_delta):
	move_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	accelleration = move_vector * move_speed
	velocity += accelleration 
	velocity *= drag
	#rotation = lerp(rotation, rotation_target, rotation_speed)
	move_and_slide()
	
func _process(_delta): 
	pass
	
func _input(event):
	if event is InputEventMouse or event is InputEventMouseButton or event is InputEventMouseMotion:
		rotation_target = set_mouse_aim()
	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		rotation_target = set_analog_stick_aim()

func set_mouse_aim():
	aim_vector = global_position.direction_to(get_global_mouse_position())
	return atan2(aim_vector.y, aim_vector.x)

func set_analog_stick_aim():
	aim_vector = Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down")
	return atan2(aim_vector.y, aim_vector.x)
	
func handle_hit():
	print("player hit")

