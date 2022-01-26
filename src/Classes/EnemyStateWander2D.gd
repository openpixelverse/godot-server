extends State2D
class_name EnemyStateWander2D


########################################################
# Variables                                            #
########################################################


var WANDER_RANGE : int = 200

var target_position : Vector2

var target_directon : Vector2

var target_path : PoolVector2Array

var _Line2D : Line2D


########################################################
# Hooks                                                #
########################################################


func _init(target: Node2D).(target):
	name = "Wander"


########################################################
# Setup                                                #
########################################################

func setup_target_position()->void:
	var target_vector = Vector2(
		rand_range(-WANDER_RANGE, WANDER_RANGE),
		rand_range(-WANDER_RANGE, WANDER_RANGE)
	)
	target_position = _Target.global_position + target_vector


func setup_target_path()->void:
	var _Navigation = get_node("/root/Server/World/Navigation")
	target_path = _Navigation.get_simple_path(_Target.global_position, target_position, false)
	
	# For debugging.
	_Line2D = Line2D.new()
	_Line2D.points = target_path
	add_child(_Line2D)


########################################################
# Methods                                              #
########################################################


func enter():
	randomize()
	setup_target_position()
	setup_target_path()


func update(delta):
	var next_position = target_position
		
	var direction = _Target.global_position.direction_to(next_position)
	
	if target_path.size() > 1:
		direction = _Target.global_position.direction_to(target_path[1])
	
	if _Target.global_position == target_path[0]:
		target_path.remove(0)
	
	var distance = _Target.global_position.distance_to(next_position)
	
	# Continue to move forward if the location is far enough away.
	if distance > 30:
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
