extends Node

signal fire(resource:ProjectileBase, location:Vector2, direction:Vector2)

signal gunswap(resource:ProjectileBase)

func emit_fire(resource:ProjectileBase, location:Vector2, direction:Vector2):
	fire.emit(resource, location, direction)
	
func emit_gunswap(resource:ProjectileBase):
	gunswap.emit(resource)
	
