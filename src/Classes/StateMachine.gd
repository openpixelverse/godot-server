extends Node
class_name StateMachine


########################################################
# Member Variables                                     #
########################################################

var states_map = {}


########################################################
# Signals                                              #
########################################################





########################################################
# Hooks                                                #
########################################################


func _init(states: Array, start_state: String = "idle")->void:
	setup_states(states)
	start_processing_states(start_state)


########################################################
# Setup                                                #
########################################################


# Setup the states of the state machine.
func setup_states(states: Array):
	for state in states:
		setup_state(state)


# Setup a single state and add it as child node.
func setup_state(state: String)->void:
	match state:
		"idle":
			pass
		_:
			assert(false, "[StateMachine] Given state '" + state + "' is not implemented yet.")


########################################################
# Methods                                              #
########################################################


# Start processing the states.
func start_processing_states(start_state: String)->void:
	states_map[start_state].enter()
