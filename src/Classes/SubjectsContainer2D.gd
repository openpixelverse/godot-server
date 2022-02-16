extends YSort
class_name SubjectsContainer2D


var _EnemiesContainer : EnemiesContainer2D
var _PlayersContainer : PlayersContainer2D


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
	setup_players(data)


# Setup the enemy spawn points and enemies.
func setup_enemies(data: Dictionary)->void:
	if data.has("enemies"):
		_EnemiesContainer = EnemiesContainer2D.new(data.enemies)
		_EnemiesContainer.name = "Enemies"
		add_child(_EnemiesContainer)


# Setup the players container.
func setup_players(data: Dictionary)->void:
	_PlayersContainer = PlayersContainer2D.new()
	_PlayersContainer.name = "Players"
	add_child(_PlayersContainer)


########################################################
# Method                                               #
########################################################


# Get the subject states from the subject containers.
func get_subject_states()->Dictionary:
	var subject_states = {}
	
	if _EnemiesContainer:
		subject_states["enemies"] = _EnemiesContainer.get_subject_states()
	
	return subject_states


# Get initial subject data for the client.
func get_subject_data(type : String, name : String)->Dictionary:
	var data : Dictionary
	match type:
		"player":
			assert(false, "[SubjectsContainer2D] Subjects of type 'player' are not yet implemented.")
		"enemy":
			data = _EnemiesContainer.get_subject_data(name)
		_:
			assert(false, "[SubjectsContainer2D] Subjects of type '" + type + "' are not yet implemented.")
	return data


# Spawn player.
func spawn_player(player_id)->void:
	_PlayersContainer.spawn_player(player_id)
