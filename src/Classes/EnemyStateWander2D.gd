extends State2D
class_name EnemyStateWander2D


########################################################
# Variables                                            #
########################################################


var WANDER_RANGE : int = 500
var MIN_DISTANCE : int =  30

var target_position : Vector2

var target_directon : Vector2

var target_path : PoolVector2Array

var _TargetArea : Area2D

var _Line2D : Line2D

onready var _Navigation = get_node("/root/Server/World/Navigation")


########################################################
# Hooks                                                #
########################################################


func _init(target: Node2D).(target):
	name = "Wander"


func _on_TargetArea_area_entered(area : Area2D)->void:
	setup_target_position()


########################################################
# Setup                                                #
########################################################

func setup_target_position()->void:
	# Make sure we get random numbers.
	randomize()
	# Setup a random position inside the wander range.
	var target_vector = Vector2(
		rand_range(-WANDER_RANGE, WANDER_RANGE),
		rand_range(-WANDER_RANGE, WANDER_RANGE)
	)
	# Set the target position relative to the current position.
	target_position = _Target.global_position + target_vector
	# Make sure we can navigate to that point through the map.
	target_position = _Navigation.get_closest_point(target_position)
	# Calculate the distance to the target position.
	var target_distance = _Target.global_position.distance_to(target_position)
	# Setup an area at the target position and connect to it.
	if _TargetArea:
		_TargetArea.queue_free()
	_TargetArea = Area2D.new()
	_TargetArea.add_child(_Target.get_node("CollisionShape").duplicate())
	_TargetArea.position = target_position
	_TargetArea.set_deferred("scale", _Target.scale)
	_TargetArea.connect("area_entered", self, "_on_TargetArea_area_entered")
	add_child(_TargetArea)
	
	# We can only continue if the target is beyond the min_distance. Otherwise
	#  the subject will just not move.
	if target_distance > MIN_DISTANCE:
		# Get the path.
		target_path = _Navigation.get_simple_path(_Target.global_position, target_position, false)
		# Remove firest element since this is the current position
		target_path.remove(0)
	else:
		# Try again.
		setup_target_position()


########################################################
# Methods                                              #
########################################################


func enter():
	setup_target_position()


func update(delta):
	var next_position = target_position
		
	var direction = _Target.global_position.direction_to(next_position)
	
	if target_path.size():
		next_position = target_path[0]
		direction = _Target.global_position.direction_to(target_path[0])
	
		if _Target.global_position == target_path[0]:
			target_path.remove(0)
	
	var distance = _Target.global_position.distance_to(next_position)
	
	# Continue to move forward if the location is far enough away.
	if distance > MIN_DISTANCE:
		_Target.velocity = _Target.velocity.move_toward(
			direction * _Target.stats.speed, 
			_Target.stats.acceleration * _Target.stats.friction * delta
		)
		_Target.velocity = _Target.move_and_slide(_Target.velocity)
	
	# If we are very close, we want to simply stop the movement.
	elif distance < 1:
		_Target.velocity = _Target.move_and_slide(Vector2.ZERO)
	
	# Otherwise reduce movement until we no longer move.
	else:
		_Target.velocity = _Target.velocity.move_toward(
			direction * _Target.stats.speed, 
			_Target.stats.acceleration * _Target.stats.friction * delta
		)
		_Target.velocity = _Target.move_and_slide(_Target.velocity * 0.75)


	# If the velocity is (0, 0) we can go back to the idle state.
	if _Target.velocity == Vector2.ZERO:
		emit_signal("finished", "idle")
	
	# Send new direction to everyone listening.
	emit_signal("update_direction", direction)
