class_name SpectralEnergyDrop
extends Area3D
@onready var life_timer = $Life

@export var energy_value = 1
@export var life:float = 3
# Called when the node enters the scene tree for the first time.
func _ready():
	life_timer.wait_time = life
	life_timer.start()
	life_timer.connect("timeout", _die)
	connect("area_entered", _on_area_entered)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _die():
	queue_free()

func _on_area_entered(area:Area3D):
	if area.is_in_group("Player"):
		SignalBus.emit_collected("SpectralEnergyDrop", energy_value)
		_die()
