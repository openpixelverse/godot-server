extends Node


########################################################
# Member Variables                                     #
########################################################


# The Server singleton will connect to the game environment through the
#  _Server node so it makes sense to load it right away.
onready var _Server = get_node("/root/Server")


########################################################
# Routes                                               #
########################################################


########################################################
# Clock


# Called whenever a client wants to dermine the latency.
remote func determine_latency(client_time)->void:
	var player_id = get_tree().get_rpc_sender_id()
	rpc_id(player_id, "receive_latency", client_time)


# Access point for the peer to fetch the server time
remote func fetch_server_time(client_time):
	# get the player id to send the data back
	var player_id = get_tree().get_rpc_sender_id()
	# send the server time including the received client time
	#  back to the client.
	rpc_id(player_id, "receive_server_time", OS.get_system_time_msecs(), client_time)


########################################################
# World


remote func load_world_data(world : String)->void:
	var world_data = OpenPixelverseAPI.load_world_data(world)
	rpc_id(get_tree().get_rpc_sender_id(), "receive_world_data", world_data)


# Send the world state to all peers.
func send_world_state(world_state : Dictionary)->void:
	rpc_unreliable_id(0, "receive_world_state", world_state)


########################################################
# Subjects


# Load initial subject data.
remote func load_subject_data(type : String, name : String)->void:
	var data = _Server.load_subject_data(type, name)
	rpc_id(get_tree().get_rpc_sender_id(), "receive_subject_data", type, name, data)
