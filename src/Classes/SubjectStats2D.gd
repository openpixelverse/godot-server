extends Node2D
class_name SubjectStats2D


########################################################
# Variables                                            #
########################################################


var friction : int setget set_friction #, get_friction
var speed : int setget set_speed #, get_speed
var acceleration : int setget set_acceleration #, get_acceleration


########################################################
# Signals                                              #
########################################################


########################################################
# Hooks                                                #
########################################################


func _init(data : Dictionary)->void:
	setup_speed(data)
	setup_friction(data)
	setup_acceleration(data)


########################################################
# Setup                                                #
########################################################


func setup_speed(data : Dictionary)->void:
	if data.has("speed"):
		assert(data.speed > 0, "[SubjectStats2D] Speed needs to have a positive value.")
		set_speed(data.speed)


func setup_friction(data : Dictionary)->void:
	if data.has("friction"):
		assert(data.friction > 0, "[SubjectStats2D] Friction needs to have a positive value.")
		set_friction(data.friction)


func setup_acceleration(data : Dictionary)->void:
	if data.has("acceleration"):
		assert(data.acceleration > 0, "[SubjectStats2D] Acceleration needs to have a positive value.")
		set_acceleration(data.acceleration)


########################################################
# Methods                                              #
########################################################


func set_friction(new_friction : int)->void:
	friction = new_friction * 500


func set_speed(new_speed : int)->void:
	speed = new_speed * 80


func set_acceleration(new_acceleration : int)->void:
	acceleration = new_acceleration * 500


func to_dict()->Dictionary:
	return {
		"friction": friction,
		"speed": speed,
		"acceleration": acceleration,
	}
