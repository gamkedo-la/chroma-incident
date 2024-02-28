extends Node2D

@onready var state_machine : StateMachine = $StateMachine
@onready var moving_state = $StateMachine/Moving
@onready var attacking_state = $StateMachine/Attacking

func _ready():
	await get_tree().create_timer(1.0).timeout
	state_machine.change_state(attacking_state)

### Demo functions, just to show the functionality
func _on_state_entered(state):
	print('Entered %s state' % [state.name.to_upper()])

func _on_state_exited(state):
	print('Exited %s state' % [state.name.to_upper()])
