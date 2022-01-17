extends StateMachine2D
class_name EnemyStateMachine2D


########################################################
# Hooks                                                #
########################################################


# Constructor.
func _init(target: Node2D, states: Array, start_state: String = "idle").(target, states, start_state)->void:
	pass


########################################################
# Methods                                              #
########################################################


# Resolve the states.
func resolve_state(state:String)->State2D:
	var _State
	
	match state:
		"idle":
			_State = EnemyStateIdle2D.new(_Target)
		"wander":
			_State = EnemyStateWander2D.new(_Target)
		_:
			assert(false, "[EnemyStateMachine2D] Given state '" + state + "' is not implemented yet.")
			
	return _State
