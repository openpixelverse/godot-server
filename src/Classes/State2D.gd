extends Node
class_name State2D


########################################################
# Member Variables                                     #
########################################################


var _Target : Node2D setget set_target


########################################################
# Signals                                              #
########################################################


signal finished(new_state)


########################################################
# Hooks                                                #
########################################################


func _init(target : Node2D):
	set_target(target)


# Called whenever a connected animation ends.
func _on_animation_finished(animation_name):
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
func handle_input(event):
	return


# Update the state.
func update(delta):
	return
