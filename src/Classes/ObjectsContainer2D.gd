extends Node2D
class_name ObjectsContainer2D


########################################################
# Hooks                                                #
########################################################


var _StaticObjectsContainer : YSort


########################################################
# Hooks                                                #
########################################################


func _init(objects: Array)->void:
	setup_objects(objects)


########################################################
# Setup                                                #
########################################################


# Add the objects as child nodes.
func setup_objects(objects: Array)->void:
	# add objects
	for object in objects:
		add_object(object)


# Add an object as child node.
func add_object(object: Dictionary)->void:
	assert(object.has("type"), "[ObjectsContainer2D] No type provided in object data.")
	
	match object.type:
		"flat":
			assert(false, "[ObjectsContainer2D] Object type 'flat' is not yet implemented.")
		"static":
			add_static_object(object)
		"dynamic":
			assert(false, "[ObjectsContainer2D] Object type 'dynamic' is not yet implemented.")
		_:
			assert(false, "[ObjectsContainer2D] Object type '" + str(object.type) + "' is not yet implemented.")


# Add static object as child node.
func add_static_object(object: Dictionary)->void:
	assert(object.has("type") and object.type == "static", "[ObjectsContainer2D] Object type provided is not 'static'.")
	
	var _Object = StaticObject2D.new(object)
	
	if _StaticObjectsContainer:
		_StaticObjectsContainer = get_node("StaticObjects")
	else:
		_StaticObjectsContainer = YSort.new()
		_StaticObjectsContainer.name = "StaticObjects"
		add_child(_StaticObjectsContainer)
	
	_StaticObjectsContainer.add_child(_Object)


# Get the object states from the object containers.
func get_object_states()->Dictionary:
	var object_states = {}
	
	if _StaticObjectsContainer:
		for _Object in _StaticObjectsContainer.get_children():
			object_states["static"] = _Object.get_state()
		
	return object_states
