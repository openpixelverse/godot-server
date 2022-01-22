extends Node2D
class_name EnemiesContainer2D


########################################################
# Hooks                                                #
########################################################


func _init(data: Dictionary)->void:
	setup_spawn_areas(data)


########################################################
# Setup                                                #
########################################################


# Setup spawn areas.
func setup_spawn_areas(data: Dictionary):
	assert(data.has("spawn_areas") and data.spawn_areas.size(), "[SubjectContainer2D] No spawn areas for available for enemies to spawn.")
	for area in data.spawn_areas:
		var _SpawnArea = SpawnArea2D.new(area)
		add_child(_SpawnArea)


########################################################
# Methods                                              #
########################################################


func get_subject_states()->Dictionary:
	var subject_states = {}
	
	for _SpawnArea in get_children():
		var enemy_states = _SpawnArea.get_subject_states()
		for enemy_name in enemy_states:
			subject_states[enemy_name] = enemy_states[enemy_name]
	
	return subject_states


func get_subject_data(name : String)->Dictionary:
	var enemy_data : Dictionary
	for _SpawnArea in get_children():
		if _SpawnArea.has_node(name):
			enemy_data = _SpawnArea.get_subject_data(name)
	return enemy_data
