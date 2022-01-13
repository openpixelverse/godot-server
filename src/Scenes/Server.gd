extends Node


########################################################
# Signals                                              #
########################################################


########################################################
# Hooks                                                #
########################################################


# Called when the node is "ready".
func _ready()->void:
	setup_server()


########################################################
# Methods                                              #
########################################################


# Setup the server.
func setup_server()->void:
	# Setup game server.
	var _WebSocketServer = WebSocketServer.new()
	# - We only need the ssl certificates if we are on a
	#    relevant environment.
	if ["prod"].has(Config.env):
		_WebSocketServer.private_key = load("res://ssl/server.key")
		_WebSocketServer.ssl_certificate = load("res://ssl/server.crt")
	# - Set the port we want to listen to.
	_WebSocketServer.listen(Config.get_value("Server", "port"), PoolStringArray(["ludus"]), true)
	# Set the _WebSocketServer as network peer in order to use it as server.
	get_tree().set_network_peer(_WebSocketServer)
	
	# Connect the events for connection failed and succeeded.
	# warning-ignore:return_value_discarded
	_WebSocketServer.connect("peer_connected", self, "_on_peer_connected")
	# warning-ignore:return_value_discarded
	_WebSocketServer.connect("peer_disconnected", self, "_on_peer_disconnected")
	
	# print some success message for debugging
	print("Server started sucessfully!")
