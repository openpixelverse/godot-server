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
