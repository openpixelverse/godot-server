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
