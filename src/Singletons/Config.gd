extends Node


########################################################
# Member Variables                                     #
########################################################


var config = false
var env = "local"


########################################################
# Methods                                              #
########################################################


# Called whenever we want to load the config from the config file.
func load_config():
	config = ConfigFile.new()
	var err = config.load("res://" + str(env) + ".cfg")
	if err != OK:
		print(err)


# Called whenever we want to access a value from the cofig.
func get_value(section, config_key, default = null):
	# Load the config if we did not do so yet.
	if !config:
		load_config()
	# Get the value from the config.
	var config_value = config.get_value(section, config_key, default)
	# Return the value from the config.
	return config_value
