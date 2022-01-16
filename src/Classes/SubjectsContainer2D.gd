extends Node2D
class_name SubjectsContainer2D


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
		var _Enemies = EnemiesContainer2D.new(data.enemies)
		_Enemies.name = "Enemies"
		add_child(_Enemies)
		
		
