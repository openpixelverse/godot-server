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

# Scale factor
var scale_factor : float = 1


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
	setup_scale_factor(object)
	setup_collision_shape(object)
	setup_position(object)


# Setup the name of this object.
func setup_name(data: Dictionary)->void:
	if data.has("name"):
		name = data.name


# Setup the collision shape of this object.
func setup_collision_shape(data: Dictionary)->void:
	if data.has("collision_shape"):
		var _CollisionShape = Builder.build_collision_shape(data.collision_shape, scale_factor)
		_CollisionShape.name = "CollisionShape"
		add_child(_CollisionShape)


# Setup the scale_factor for the object.
func setup_scale_factor(data: Dictionary)->void:
	if data.has("scale_factor"):
		scale_factor = data.scale_factor


# Setup the position of the object.
func setup_position(data: Dictionary)->void:
	if data.has("position"):
		set_position(data.position)
