class_name SpectralEnergyDrop
extends Area2D
@onready var life_timer = $Life

@export var energy_value = 1
@export var life:float = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	life_timer.wait_time = life
	life_timer.start()
	life_timer.connect("timeout", _die)
	connect("body_entered", _on_body_entered)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _die():
	queue_free()

func _on_body_entered(body:Node2D):
	print(body)
	if body.is_in_group("Player"):
		#basically only want to collect if body is Player. 
		SignalBus.emit_collected("SpectralEnergyDrop", energy_value)
		_die()
