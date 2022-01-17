"""
Concept: http://gameprogrammingpatterns.com/state.html
Tutorial: https://github.com/GDQuest/godot-demos/blob/master/2018/04-24-finite-state-machine/player_v2/state_machine.gd
"""

extends Node
class_name StateMachine2D


########################################################
# Member Variables                                     #
########################################################


var _Target : Node2D
var state_map : Dictionary = {}
var state_stack : Array = []
var _CurrentState : State2D


########################################################
# Signals                                              #
########################################################


signal state_changed(new_state)


########################################################
# Hooks                                                #
########################################################


# Constructor.
func _init(target: Node2D, states: Array, start_state: String = "idle")->void:
	set_physics_process(false)
	setup_state_machine(target, states, start_state)


func _ready()->void:
	set_physics_process(true)


# Called whenever the state changes.
func _on_change_state(new_state: String)->void:
	change_state(new_state)


# Called whenever there is user input.
func _input(event)->void:
	_CurrentState.handle_input(event)


# Called during the physics processing step of the main loop.
func _physics_process(delta)->void:
	if _CurrentState:
		_CurrentState.update(delta)


########################################################
# Setup                                                #
########################################################


# Setup the state machine.
func setup_state_machine(target: Node2D, states: Array, start_state: String)->void:
	setup_target(target)
	setup_states(states)
	setup_stack(start_state)


# Setup the target of the state machine.
func setup_target(target)->void:
	_Target = target


# Setup the states of the state machine.
func setup_states(states: Array):
	for state in states:
		setup_state(state)


# Setup a single state and add it as child node.
func setup_state(state: String)->void:
	var _State = resolve_state(state)
	
	state_map[state] = _State
	add_child(_State)
	_State.connect("finished", self, "_on_change_state")


# Setup the initial state of the state machine.
func setup_stack(start_state: String)->void:
	validate_new_state(start_state)
	
	state_stack.push_front(state_map[start_state])
	_CurrentState = state_stack[0]
	_CurrentState.enter()


########################################################
# Methods                                              #
########################################################


# Resolve the given state.
func resolve_state(state:String)->State2D:
	var _State
	
	match state:
		"idle":
			_State = StateIdle2D.new(_Target)
		_:
			assert(false, "[StateMachine2D] Given state '" + state + "' is not implemented yet.")
	
	return _State


# Change the state to the new state.
func change_state(new_state: String)->void:
	validate_new_state(new_state)
		
	if _CurrentState:
		_CurrentState.exit()
	
	if new_state == "previous":
		state_stack.pop_front()
	else:
		state_stack[0] = state_map[new_state]
	
	_CurrentState = state_stack[0]
	emit_signal("state_changed", _CurrentState) # TODO: check if we actually need this currently.
	
	if new_state != "previous":
		_CurrentState.enter()


# Validate in incoming state against the state map.
func validate_new_state(new_state: String)->void:
	if !state_map.has(new_state):
		assert(false, "[StateMachine2D] The given new state '" + new_state + "' is not available.")
