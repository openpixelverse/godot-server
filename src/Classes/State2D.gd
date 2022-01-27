extends Node
class_name State2D


########################################################
# Member Variables                                     #
########################################################


var _Target : Node2D setget set_target


########################################################
# Signals                                              #
########################################################


# warning-ignore:unused_signal
signal finished(new_state)
# warning-ignore:unused_signal
signal update_direction(new_direction)


########################################################
# Hooks                                                #
########################################################


func _init(target : Node2D):
	set_target(target)


# Called whenever a connected animation ends.
func _on_animation_finished(_animation_name):
	return


func set_target(target : Node2D)->void:
	_Target = target


########################################################
# Methods                                              #
########################################################


# Initialize the state. Eg. change the animation.
func enter():
	return


# Clean up the state. Reinitialize values like a timer.
func exit():
	return


# Handle user input.
func handle_input(_event):
	return


# Update the state.
func update(_delta):
	return
