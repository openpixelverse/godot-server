extends StaticBody2D
class_name StaticObject2D


########################################################
# Member Variables                                     #
########################################################


# States
const DEFAULT : String = "default"

# Default state
var state : String = DEFAULT

# Stats
var stats : Dictionary


########################################################
# Hooks                                                #
########################################################


func _init(object: Dictionary)->void:
	setup_object(object)


########################################################
# Setup                                                #
########################################################


# Setup the object instance.
func setup_object(object: Dictionary)->void:
	setup_name(object)
	setup_collision_shape(object)
	setup_position(object)
	setup_scale_factor(object)


# Setup the name of this object.
func setup_name(data: Dictionary)->void:
	if data.has("name"):
		name = data.name


# Setup the collision shape of this object.
func setup_collision_shape(data: Dictionary)->void:
	if data.has("collision_shape"):
		Builder2D.add_collision_shape(self, data.collision_shape)


# Setup the scale_factor for the object.
func setup_scale_factor(data: Dictionary)->void:
	if data.has("scale_factor"):
		set_scale(Vector2(data.scale_factor, data.scale_factor))


# Setup the position of the object.
func setup_position(data: Dictionary)->void:
	if data.has("position"):
		set_position(data.position)


########################################################
# Methods                                              #
########################################################


func get_state()->Dictionary:
	return {
		"state": state,
		"stats": stats,
	}
