class_name Player3D
extends CharacterBody3D

@export var move_speed:float = 2
@export var drag:float = 0.85
@export var rotation_speed:float = 0.3
@export var spectral_energy:float = 0

var move_vector:Vector3 
var aim_vector:Vector3
var rotation_target:float
var body_rotation_target:float
var accelleration:Vector3
var mouse_in_use:bool = true
var holding_beacon:bool = false
@onready var beacon_transform:RemoteTransform2D = $BeaconTransform

#@onready var head = $PlayerGraphic/Head
#@onready var shoulders = $PlayerGraphic/Shoulders
#@onready var torso = $PlayerGraphic/Torso
#@onready var left_leg = $PlayerGraphic/leftLeg
#@onready var right_leg = $PlayerGraphic/rightLeg
#@onready var feet = $PlayerGraphic/Feet
#@onready var left_foot_marker = $PlayerGraphic/Feet/leftFootMarker
#@onready var right_foot_marker = $PlayerGraphic/Feet/rightFootMarker
#@onready var left_foot = $PlayerGraphic/Feet/leftFootMarker/leftFoot
#@onready var right_foot = $PlayerGraphic/Feet/rightFootMarker/rightFoot


#@onready var health_component = get_node("HealthComponent")

func _ready():
	Global.register_player(self)
	SignalBus.connect("collected", _collected_something)
func _physics_process(_delta):
	var xz_vector =  Input.get_vector("move_left", "move_right", "move_up", "move_down")
	move_vector = Vector3(xz_vector.x, 0.0, xz_vector.y)
	accelleration = move_vector * move_speed
	velocity += Vector3(accelleration.x, 0.0, accelleration.z) 
	velocity *= drag
	body_rotation_target = atan2(move_vector.z, move_vector.x) - PI/2
	#rotation.y = body_rotation_target
	move_and_slide()
	
func _process(_delta): 
	#head.rotation = rotation_target
	#shoulders.rotation = body_rotation_target
	#torso.rotation = body_rotation_target
	#feet.rotation = body_rotation_target
	#left_leg.global_position = left_foot_marker.global_position
	#right_leg.global_position = right_foot_marker.global_position
	pass
	
func _input(event):
	if event is InputEventMouse or event is InputEventMouseButton or event is InputEventMouseMotion:
		rotation_target = set_mouse_aim()
	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		rotation_target = set_analog_stick_aim()

func set_mouse_aim():
	var mousepos = get_viewport().get_mouse_position()
	aim_vector = global_position.direction_to(Vector3(mousepos.x, 0.0, mousepos.y))
	return atan2(aim_vector.y, aim_vector.x)

func set_analog_stick_aim():
	var xz =  Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down")
	aim_vector = Vector3(xz.x, 0.0, xz.y)
	return atan2(aim_vector.y, aim_vector.x)
	
# Todo - Pass in damage from projectile as parameter
func handle_hit():
	pass
	#health_component.take_damage(5)
	
func _collected_something(item:String, value:float):
	#for now there's just the energy drops. function signature may change,
	#not doing anything with 'item' for now
	spectral_energy += value
	
func grab_beacon(beacon:Beacon):
	holding_beacon = true
	#if Input.is_action_just_pressed("Move Beacon"):
		#var offset = global_position - beacon.global_position
		#beacon_transform.position = -offset
	#beacon_transform.set_remote_node(beacon.get_path())
	#beacon_transform.update_position = true

func drop_beacon():
	holding_beacon = false
	beacon_transform.update_position = false
