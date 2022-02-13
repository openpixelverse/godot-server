extends Node
class_name Builder2D


########################################################
# Methods                                              #
########################################################


# Add build up a collision shape node and add it to the target node.
static func add_collision_shape(target: Node2D, data: Dictionary)->void:
	var _CollisionShape = build_collision_shape(data)
	target.add_child(_CollisionShape)


# Build a collision shape form data.
static func build_collision_shape(data: Dictionary)->CollisionShape2D:
	assert(data.has("type"), "[Builder2D] No type provided for 'collision_shape'.")
	
	var _CollisionShape
	
	match data.type:
		"circle":
			_CollisionShape = build_collision_shape_circle(data)
		"rectangle":
			_CollisionShape = build_collision_shape_rectangle(data)
		_:
			assert(false, "[Builder2D] No valid type for collision_shape provided.")
	
	_CollisionShape.name = "CollisionShape"
	
	return _CollisionShape


# Build circle collision shape from data.
static func build_collision_shape_circle(data: Dictionary)->CollisionShape2D:
	var _CollisionShape = CollisionShape2D.new()
	var _Shape = CircleShape2D.new()
	_Shape.set_radius(data.radius)
	_CollisionShape.shape = _Shape
	_CollisionShape.set_position(Vector2(int(data.position.x) * 2, int(data.position.y) * 2))
	
	return _CollisionShape


# Build rectangle collision shape from data.
static func build_collision_shape_rectangle(data: Dictionary)->CollisionShape2D:
	var _CollisionShape = CollisionShape2D.new()

	var _Shape = RectangleShape2D.new()
	_Shape.set_extents(Vector2(int(data.extents.x), int(data.extents.y)))
	_CollisionShape.shape = _Shape
	_CollisionShape.set_position(Vector2(int(data.position.x) * 2, int(data.position.y) * 2))
	
	return _CollisionShape


# Build and add player detection zone to target.
func add_player_collision_shape(data: Dictionary)->void:
	var _PlayerDetectionZone
	
