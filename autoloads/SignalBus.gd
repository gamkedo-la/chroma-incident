extends Node

signal fire(resource:ProjectileBase, location:Vector2, direction:Vector2, fired_by_enemy:bool)
signal gunmod(effectType:int)

func emit_fire(resource:ProjectileBase, location:Vector2, direction:Vector2, fired_by_enemy:bool):
	fire.emit(resource, location, direction, fired_by_enemy)
	
func emit_gunmod(effectType:int):
	gunmod.emit(effectType)
	
	
