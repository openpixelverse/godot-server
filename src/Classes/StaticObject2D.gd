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

# Shape
var shape_polygon : PoolVector2Array


########################################################
# Signals                                              #
########################################################


signal subtract_polygon_of_object_from_navigation_area(polygon)


########################################################
# Hooks                                                #
########################################################


func _init(object: Dictionary)->void:
	setup_object(object)


func _ready()->void:
	if shape_polygon:
		emit_signal("subtract_polygon_of_object_from_navigation_area", shape_polygon)


########################################################
# Setup                                                #
########################################################


# Setup the object instance.
func setup_object(object: Dictionary)->void:
	setup_name(object)
	setup_position(object)
	setup_scale_factor(object)
	setup_collision_shape(object)


# Setup the name of this object.
func setup_name(data: Dictionary)->void:
	if data.has("name"):
		name = data.name


# Setup the collision shape of this object.
func setup_collision_shape(data: Dictionary)->void:
	if data.has("collision_shape"):
#		Builder2D.add_collision_shape(self, data.collision_shape)
		var _CollisionShape = Builder2D.build_collision_shape(data.collision_shape)
		add_child(_CollisionShape)
		# create plygon from rectangle shape.
		if data.collision_shape.type == "rectangle":
			var safety_space = 50
			
			var extents = _CollisionShape.shape.extents
			
			var polygon_position = Vector2.ZERO
			if data.collision_shape.has("position"):
				polygon_position += Vector2(data.collision_shape.position.x, data.collision_shape.position.y)
				
			if data.has("scale_factor"):
				extents *= data.scale_factor
				polygon_position *= data.scale_factor * 2
			
			polygon_position += global_position
			
			shape_polygon = PoolVector2Array([
				Vector2(polygon_position.x - extents.x - safety_space, polygon_position.y - extents.y - safety_space),
				Vector2(polygon_position.x + extents.x + safety_space, polygon_position.y - extents.y - safety_space),
				Vector2(polygon_position.x + extents.x + safety_space, polygon_position.y + extents.y + safety_space),
				Vector2(polygon_position.x - extents.x - safety_space, polygon_position.y + extents.y + safety_space),
			])


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
		"name": name,
		"state": state,
		"stats": stats,
		"position": global_position,
	}
