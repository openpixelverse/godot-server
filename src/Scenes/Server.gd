extends Node


########################################################
# Variables                                            #
########################################################


var _World


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
	setup_connection()
	setup_world()


# Setup the websocket server to enable client connections.
func setup_connection()->void:
	# Setup game server.^^
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
	
	
# Setup the game world.
func setup_world()->void:
	# Load world data from API.
	var world_data = OpenPixelverseAPI.load_world_data(Config.get_value("World", "world", "default"))
	
	# Validate type.
	assert(world_data.has("type"), "[Server] No type in world data.")
	
	# Match the type.
	match world_data.type:
		"2D":
			_World = OpenPixelverseWorld2D.new(world_data)
		_:
			assert(false, "[Server] No valid type in world data.")
	
	# Set the name of the world node to "World".
	_World.name = "World"
	
	# Add the world node as child to the server.
	add_child(_World)


# Load initial subject data.
func load_subject_data(type : String, name : String)->Dictionary:
	return _World.load_subject_data(type, name)
