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
