extends Node2D
class_name ObjectsContainer2D


########################################################
# Hooks                                                #
########################################################


func _init(objects: Array)->void:
	add_objects(objects)


########################################################
# Methods                                              #
########################################################


# Add the objects as child nodes.
func add_objects(objects: Array)->void:
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
	
	var _StaticObjectsContainer
	if has_node("StaticObjects"):
		_StaticObjectsContainer = get_node("StaticObjects")
	else:
		_StaticObjectsContainer = YSort.new()
		_StaticObjectsContainer.name = "Static Objects"
		add_child(_StaticObjectsContainer)
	
	_StaticObjectsContainer.add_child(_Object)
