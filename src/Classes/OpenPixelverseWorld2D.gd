extends Node2D
class_name OpenPixelverseWorld2D


########################################################
# Hooks                                                #
########################################################


func _init(data: Dictionary)->void:
	._init()
	setup_world(data)


########################################################
# Setup                                                #
########################################################


# Setup the world instance.
func setup_world(data: Dictionary)->void:
	setup_limits(data)
	setup_objects(data)


# Setup the world limits from data.
func setup_limits(data: Dictionary)->void:
	# Only proceed if we got data for the limits.
	if data.has("limits"):
		# Validate world limits.
		assert(data.limits.has("top"), "[OpenPixelverseWorld2D] No top limit provided in world limits.")
		assert(data.limits.has("bottom"), "[OpenPixelverseWorld2D] No bottom limit provided in world limits.")
		assert(data.limits.has("left"), "[OpenPixelverseWorld2D] No left limit provided in world limits.")
		assert(data.limits.has("right"), "[OpenPixelverseWorld2D] No right limit provided in world limits.")
		# Setup the world limits.
		add_child(build_border("Border Top", Vector2(data.limits.right, 1), Vector2(0, -2)))
		add_child(build_border("Border Right", Vector2(1, data.limits.bottom), Vector2(data.limits.right + 2, 0)))
		add_child(build_border("Border Bottom", Vector2(data.limits.right, 1), Vector2(0, data.limits.bottom + 2)))
		add_child(build_border("Border Left", Vector2(1, data.limits.bottom), Vector2(-2, 0)))


# Build border from data.
func build_border(name: String, extents: Vector2, position: Vector2)->StaticBody2D:
	var _Border = StaticBody2D.new()
	_Border.name = name
	_Border.position = position
	var _CollisionShape = CollisionShape2D.new()
	_CollisionShape.name = "CollisionShape"
	var _Shape = RectangleShape2D.new()
	_Shape.set_extents(extents)
	_CollisionShape.set_shape(_Shape)
	_Border.add_child(_CollisionShape)
	return _Border


# Setup the objects node and all it's childs.
func setup_objects(data: Dictionary)->void:
	if data.has("objects") and data.objects.size():
		var _Objects = ObjectsContainer2D.new(data.objects)
		_Objects.name = "Objects"
		add_child(_Objects)
