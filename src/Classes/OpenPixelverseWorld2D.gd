extends Node2D
class_name OpenPixelverseWorld2D


########################################################
# Variables                                            #
########################################################


var world_limits : Dictionary setget set_world_limits

var _ObjectsContainer : ObjectsContainer2D
var _SubjectsContainer : SubjectsContainer2D
var _Navigation : Navigation2D
var _NavigationPolygonInstance : NavigationPolygonInstance


########################################################
# Hooks                                                #
########################################################


func _init(data: Dictionary)->void:
	setup_world(data)


func _physics_process(_delta)->void:
	send_world_state()


func _on_reset_navigation_area()->void:
	_Navigation.queue_free()
	setup_navigation_area()


func _on_subtract_polygon_from_navigation_area(polygon_to_subtract : PoolVector2Array)->void:
	subtract_polygon_from_navigation_area(polygon_to_subtract)


########################################################
# Setup                                                #
########################################################


# Setup the world instance.
func setup_world(data: Dictionary)->void:
	setup_world_limits(data)
	setup_objects(data)
	setup_subjects(data)
	setup_navigation_area()


# Setup the world limits from data.
func setup_world_limits(data: Dictionary)->void:
	# Only proceed if we got data for the limits.
	if data.has("limits"):
		set_world_limits(data.limits)
		# Create container node for limits.
		var _Limits = Node2D.new()
		_Limits.name = "Limits"
		# Setup the world limits.
		_Limits.add_child(build_border("Border Top", Vector2(data.limits.right, 1), Vector2(0, -2)))
		_Limits.add_child(build_border("Border Right", Vector2(1, data.limits.bottom), Vector2(data.limits.right + 2, 0)))
		_Limits.add_child(build_border("Border Bottom", Vector2(data.limits.right, 1), Vector2(0, data.limits.bottom + 2)))
		_Limits.add_child(build_border("Border Left", Vector2(1, data.limits.bottom), Vector2(-2, 0)))
		# Add the container node as child node of the world.
		add_child(_Limits)


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
		_ObjectsContainer = ObjectsContainer2D.new(data.objects)
		_ObjectsContainer.name = "Objects"
		add_child(_ObjectsContainer)
		# warning-ignore:return_value_discarded
		_ObjectsContainer.connect("subtract_polygon_from_navigation_area", self, "_on_subtract_polygon_from_navigation_area")


# Setup subjects node and all it's children.
func setup_subjects(data: Dictionary)->void:
	if data.has("subjects"):
		pass
		var _Subjects = SubjectsContainer2D.new(data.subjects)
		_Subjects.name = "Subjects"
		add_child(_Subjects)
		_SubjectsContainer = _Subjects


# Setup navigation area of the world.
func setup_navigation_area()->void:
	if not world_limits.empty():
		var safety_space = 50
		_Navigation = Navigation2D.new()
		_Navigation.name = "Navigation"
		_NavigationPolygonInstance = NavigationPolygonInstance.new()
		_NavigationPolygonInstance.name = "NavigationPolygonInstance"
		var _WorldPolygon = NavigationPolygon.new()
		var world_polygon_outline = PoolVector2Array([
			Vector2(world_limits.left + safety_space, world_limits.top + safety_space),
			Vector2(world_limits.right - safety_space, world_limits.top + safety_space),
			Vector2(world_limits.right - safety_space, world_limits.bottom - safety_space),
			Vector2(world_limits.left + safety_space, world_limits.bottom - safety_space),
		])
		_WorldPolygon.add_outline(world_polygon_outline)
		_WorldPolygon.make_polygons_from_outlines()
		_NavigationPolygonInstance.navpoly = _WorldPolygon
		_Navigation.add_child(_NavigationPolygonInstance)
		add_child(_Navigation)


########################################################
# Methods                                              #
########################################################


func set_world_limits(limits : Dictionary)->void:
	# Validate world limits.
	assert(limits.has("top"), "[OpenPixelverseWorld2D] No top limit provided in world limits.")
	assert(limits.has("bottom"), "[OpenPixelverseWorld2D] No bottom limit provided in world limits.")
	assert(limits.has("left"), "[OpenPixelverseWorld2D] No left limit provided in world limits.")
	assert(limits.has("right"), "[OpenPixelverseWorld2D] No right limit provided in world limits.")
	# Save the world limits
	world_limits = limits


func send_world_state()->void:
	var world_state = {
		"time": OS.get_system_time_msecs(),
		"objects": get_objects_container_state(),
		"subjects": get_subjects_container_states(),
	}
	Router.send_world_state(world_state)


func get_objects_container_state()->Dictionary:
	return _ObjectsContainer.get_object_states()


func get_subjects_container_states()->Dictionary:
	return _SubjectsContainer.get_subject_states()


# Load initial subject data for the client.
func load_subject_data(type: String, name : String)->Dictionary:
	return _SubjectsContainer.get_subject_data(type, name)


# Subtract a given polygon from the navigation area.
func subtract_polygon_from_navigation_area(polygon_to_subtract : PoolVector2Array)->void:
	var _NavigationPolygon = _NavigationPolygonInstance.get_navigation_polygon()
	_NavigationPolygon.add_outline(polygon_to_subtract)
	_NavigationPolygon.make_polygons_from_outlines()
	_NavigationPolygonInstance.set_navigation_polygon(_NavigationPolygon)
	_NavigationPolygonInstance.enabled = false
	_NavigationPolygonInstance.enabled = true
