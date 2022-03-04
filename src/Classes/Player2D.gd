extends Subject2D
class_name Player2D


########################################################
# Hooks                                                #
########################################################


func _init(data: Dictionary).(data)->void:
	pass


########################################################
# Setup                                                #
########################################################

# Setup the collision shape of the subject.
func setup_collision_shape(data: Dictionary)->void:
	if data.has("collision_shape"):
		data.collision_shape.color = Color.skyblue
		Builder2D.add_collision_shape(self, data.collision_shape)


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
