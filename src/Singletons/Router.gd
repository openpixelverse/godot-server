extends Node


########################################################
# Member Variables                                     #
########################################################


# The Server singleton will connect to the game environment through the
#  _Server node so it makes sense to load it right away.
onready var _Server = get_node("/root/Server")


########################################################
# Helpers                                              #
########################################################


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
# Client
