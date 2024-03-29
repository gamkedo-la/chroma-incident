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
#@onready var beacon_transform:RemoteTransform2D = $BeaconTransform
#@onready var aim_cursor = $"aim cursor"
@onready var camera = $Camera3D
@onready var player_body = $PlayerBody
@onready var marker_3d = $Marker3D




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
	player_body.rotation.y = body_rotation_target
	#aim_cursor.rotation.y = rotation_target + PI/2
	move_and_slide()
	
func _process(_delta): 
	pass
	
func _input(event):
	if event is InputEventMouse or event is InputEventMouseButton or event is InputEventMouseMotion:
		rotation_target = set_mouse_aim(event)
	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		rotation_target = set_analog_stick_aim()

func set_mouse_aim(event):
	var space_state = get_world_3d().direct_space_state
	var from = camera.project_ray_origin(event.position)
	var to = from + camera.project_ray_normal(event.position) * 3000
	var ray_query = PhysicsRayQueryParameters3D.create(from, to)
	var intersection = space_state.intersect_ray(ray_query)
	var angle = 0
	if not intersection.is_empty():
		marker_3d.look_at(intersection.position)
		angle = marker_3d.rotation.y
	#print(angle)
	return angle

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
	#beacon_transform.update_position = false

