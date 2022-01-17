extends State2D
class_name EnemyStateWander2D


########################################################
# Variables                                            #
########################################################


var WANDER_RANGE : int = 200

var target_position : Vector2


########################################################
# Hooks                                                #
########################################################


func _init(target: Node2D).(target):
	name = "Wander"


########################################################
# Setup                                                #
########################################################

func setup_target_position()->void:
	randomize()
	var target_vector = Vector2(
		rand_range(-WANDER_RANGE, WANDER_RANGE),
		rand_range(-WANDER_RANGE, WANDER_RANGE)
	)
	target_position = _Target.global_position + target_vector


########################################################
# Methods                                              #
########################################################


func enter():
	setup_target_position()


func update(delta):
	var direction = _Target.global_position.direction_to(target_position)
	
	var distance = _Target.global_position.distance_to(target_position)
	
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
