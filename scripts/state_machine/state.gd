extends Node
class_name StateNode

signal entered(state)
signal exited(state)

### Abstract methods to be overriden
func enter():
	pass

func exit():
	pass

func process(delta):
	pass

func physics_process(delta):
	pass
