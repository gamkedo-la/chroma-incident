extends Node

@onready var player = Global.player

signal fire(resource:ProjectileBase, location:Vector3, direction:Vector3, fired_by_enemy:bool)
signal gunmod(effectType:int)
signal collected(item:String, value:float)
signal use_item(item:String, value:float)
signal spawn_energy_drops(value:int, amount:int, location:Vector2)

func emit_fire(resource:ProjectileBase, location:Vector3, direction:Vector3, fired_by_enemy:bool):
	fire.emit(resource, location, direction, fired_by_enemy)
	
func emit_gunmod(effectType:int):
	gunmod.emit(effectType)
	
func emit_collected(item:String, value:float):
	collected.emit(item, value)

func emit_use_item(item:String, value:float):
	use_item.emit(item, value)
	
func emit_spawn_energy_drops(value:float, amount:float, location:Vector3):
	spawn_energy_drops.emit(value, amount, location)
	
