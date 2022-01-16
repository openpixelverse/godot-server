extends KinematicBody2D
class_name Subject2D


########################################################
# Member Variables                                     #
########################################################


########################################################
# States

var _States : StateMachine
#var current_state:State2D


########################################################
# Hooks                                                #
########################################################


func _init(data: Dictionary)->void:
	setup_subject(data)


########################################################
# Setup                                                #
########################################################


# Setup the subject.
func setup_subject(data: Dictionary)->void:
	setup_states(data)
#	setup_state(data)


# Setup the available states of the subject.
func setup_states(data: Dictionary)->void:
	if data.has("states"):
		_States = StateMachine.new(data.states)
		_States.name = "States"
		add_child(_States)


# Setup the subject state.
#func setup_state(data: Dictionary)->void:
#	if data.has("state"):
#		assert(states.has(data.state), "[Subject2D] Given state is not valid.")
#		current_state = states[data.state]
