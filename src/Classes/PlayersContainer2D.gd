extends Node2D
class_name PlayersContainer2D

########################################################
# Variables                                            #
########################################################

const player_spawn_point : Vector2 = Vector2(512, 320)
#const player_spawn_point : Vector2 = Vector2(100, 100)

########################################################
# Methods                                              #
########################################################

# Spawn a player as child of this container.
func spawn_player(player_id)->void:
	# Load data from api.
	var data = OpenPixelverseAPI.load_player_data(str(player_id))
	# Create new player instance.
	var _Player = Player2D.new(data)
	# Set the name of the player node to player_id.
	_Player.name = str(player_id)
	# Add the player node as child of this container.
	add_child(_Player, true)
	# Set the player position.
	_Player.set_position(player_spawn_point)


# Despawn a player if it exists as child.
func despawn_plyer(player_id)->void:
	var _Player = get_node(str(player_id))
	if _Player:
		_Player.queue_free()


func get_subject_states()->Dictionary:
	var subject_states = {}
	
	for _Player in get_children():
		subject_states[_Player.name] = _Player.get_state()
	
	return subject_states


func get_subject_data(name : String)->Dictionary:
	var player_data : Dictionary
	player_data = OpenPixelverseAPI.load_player_data(name)
	return player_data
