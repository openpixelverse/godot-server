extends YSort
class_name SubjectsContainer2D


var _EnemiesContainer : EnemiesContainer2D


########################################################
# Hooks                                                #
########################################################


func _init(data: Dictionary)->void:
	setup_subjects(data)


########################################################
# Setup                                                #
########################################################


# Setup the subjects container.
func setup_subjects(data: Dictionary)->void:
	setup_enemies(data)


# Setup the enemy spawn points and enemies.
func setup_enemies(data: Dictionary)->void:
	if data.has("enemies"):
		_EnemiesContainer = EnemiesContainer2D.new(data.enemies)
		_EnemiesContainer.name = "Enemies"
		add_child(_EnemiesContainer)


########################################################
# Method                                               #
########################################################


# Get the subject states from the subject containers.
func get_subject_states()->Dictionary:
	var subject_states = {}
	
	if _EnemiesContainer:
		subject_states["enemies"] = _EnemiesContainer.get_subject_states()
	
	return subject_states
