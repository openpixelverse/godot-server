extends Subject2D
class_name Enemy2D


########################################################
# Hooks                                                #
########################################################


func _init(data: Dictionary).(data)->void:
	pass


########################################################
# Setup                                                #
########################################################


# Setup the available states of the subject.
func setup_states(data: Dictionary)->void:
	if data.has("states"):
		var start_state = "idle"
		if data.has("start_state"):
			start_state = data.start_state
		_States = EnemyStateMachine2D.new(self, data.states, start_state)
		_States.name = "States"
		add_child(_States)
		# warning-ignore:return_value_discarded
		_States.connect("state_changed", self, "_on_state_changed")
		# warning-ignore:return_value_discarded
		_States.connect("update_direction", self, "_on_update_direction")


# Get the state of the enemy in order to use it for the world state.
func get_state()->Dictionary:
	var state_data = {
		"name": name,
		"stats": stats.to_dict(),
		"position": global_position,
		"direction": direction,
	}
	
	if current_state:
		state_data["state"] = current_state
	
	return state_data
