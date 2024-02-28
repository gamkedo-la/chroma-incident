extends Node
class_name StateMachine

signal changed_state(previous, current)

@export var initial_state : StateNode
@export var manual_update : bool = false

var current_state : StateNode

### Callback functions
func _ready():
	change_state(initial_state)

func _process(delta):
	if manual_update:
		return
	process(delta)

func _physics_process(delta):
	if manual_update:
		return
	physics_process(delta)

### Update functions
func process(delta):
	current_state.process(delta)

func physics_process(delta):
	current_state.physics_process(delta)

func change_state(new_state: StateNode):
	var old_state = current_state
	if old_state:
		old_state.exit()
		old_state.exited.emit(old_state)
	
	current_state = new_state
	
	new_state.enter()
	new_state.entered.emit(new_state)
	
	changed_state.emit(old_state, new_state)
