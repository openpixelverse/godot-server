extends Node
class_name Builder


########################################################
# Methods                                              #
########################################################


# Build a collision shape form data.
static func build_collision_shape(data: Dictionary, scale_factor: float = 1)->CollisionShape2D:
	assert(data.has("type"), "[Builder] No type provided for 'collision_shape'.")
	
	var _CollisionShape
	
	match data.type:
		"circle":
			_CollisionShape = build_collision_shape_circle(data, scale_factor)
		"rectangle":
			_CollisionShape = build_collision_shape_rectangle(data, scale_factor)
	
	return _CollisionShape


# Build circle collision shape from data.
static func build_collision_shape_circle(data: Dictionary, scale_factor: float = 1)->CollisionShape2D:
	var _CollisionShape = CollisionShape2D.new()
	_CollisionShape.name = "CollisionShape"
	var _Shape = CircleShape2D.new()
	_Shape.set_radius(data.radius)
	_CollisionShape.shape = _Shape
	_CollisionShape.set_position(Vector2(int(data.position.x) * 2, int(data.position.y) * 2))
	_CollisionShape.set_scale(Vector2(scale_factor, scale_factor))
	
	return _CollisionShape


# Build rectangle collision shape from data.
static func build_collision_shape_rectangle(data: Dictionary, scale_factor: float = 1)->CollisionShape2D:
	var _CollisionShape = CollisionShape2D.new()
	_CollisionShape.name = "CollisionShape"
	var _Shape = RectangleShape2D.new()
	_Shape.set_extents(Vector2(int(data.extents.x), int(data.extents.y)))
	_CollisionShape.shape = _Shape
	_CollisionShape.set_position(Vector2(int(data.position.x) * 2, int(data.position.y) * 2))
	_CollisionShape.set_scale(Vector2(scale_factor, scale_factor))
	
	return _CollisionShape
