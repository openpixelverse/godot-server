extends Node


########################################################
# Member Variables                                     #
########################################################


var config = false
var env = "prod"


########################################################
# Methods                                              #
########################################################


# Called whenever we want to load the config from the config file.
func load_config():
	config = ConfigFile.new()
	var err = config.load("res://" + str(env) + ".cfg")
	if err != OK:
		print(err)


# Called when we are ready to load game internal configuration values.
func load_additional_config():
	# set some additional variables
	# - Server
	config.set_value("Server", "player_id", get_tree().get_network_unique_id())


# Called whenever we want to access a value from the cofig.
func get_value(section, config_key, default = null):
	# Load the config if we did not do so yet.
	if !config:
		load_config()
	# Get the value from the config.
	var config_value = config.get_value(section, config_key, default)
	# Return the value from the config.
	return config_value
