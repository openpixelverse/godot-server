extends KinematicBody2D
class_name Subject2D


########################################################
# Member Variables                                     #
########################################################

var _States : StateMachine2D

var current_state : String

var stats : SubjectStats2D

var direction : Vector2

var velocity : Vector2


########################################################
# Hooks                                                #
########################################################


func _init(data: Dictionary)->void:
	setup_subject(data)


func _on_state_changed(new_state : String)->void:
	change_state(new_state)


func _on_update_direction(new_direction : Vector2)->void:
	update_direction(new_direction)


########################################################
# Setup                                                #
########################################################


# Setup the subject.
func setup_subject(data: Dictionary)->void:
	setup_stats(data)
	setup_states(data)
	setup_scale_factor(data)
	setup_direction(data)
	setup_collision_shape(data)
#	setup_player_detection_zone(data) # TODO: Try to setup the player detection zone through the seek_player state.


# Setup subject stats.
func setup_stats(data: Dictionary)->void:
	if data.has("stats"):
		stats = SubjectStats2D.new(data.stats)


# Setup the available states of the subject.
func setup_states(data: Dictionary)->void:
	if data.has("states"):
		var start_state = "idle"
		if data.has("start_state"):
			start_state = data.start_state
		_States = StateMachine2D.new(self, data.states, start_state)
		_States.name = "States"
		add_child(_States)
		_States.connect("state_changed", self, "_on_state_changed")
		_States.connect("update_direction", self, "_on_update_direction")


# Setup scale factor.
func setup_scale_factor(data: Dictionary)->void:
	if data.has("scale_factor"):
		var scale_factor_type = typeof(data.scale_factor)
		assert([TYPE_REAL, TYPE_INT, TYPE_DICTIONARY].has(scale_factor_type), "[Subject2D] No valid scale factor provided.")
		var scale_factor = data.scale_factor
		if typeof(scale_factor) == TYPE_DICTIONARY:
			assert(scale_factor.has("type"), "[Subject2D] No type for scale factor dictionary provided.")
			match scale_factor.type:
				"random":
					assert(scale_factor.has("options"), "[Subject2D] No options provided for scale factor of type 'random'.")
					assert(scale_factor.options.has("min"), "[Subject2D] No min value provided in options of scale factor of type 'random'.")
					assert(scale_factor.options.has("max"), "[Subject2D] No max value provided in options of scale factor of type 'random'.")
					scale_factor = Helper.randf_range(scale_factor.options.min, scale_factor.options.max)
				_:
					assert(false, "[Subject2D] No valid type for scale factor dictionary provided.")
			
		set_scale(Vector2(scale_factor, scale_factor)) # TODO: see if we can get rid of the scale_factor by using the Node2D.scale.


# Setup the direction the player is looking to.
func setup_direction(data: Dictionary)->void:
	if data.has("direction"):
		direction = data.direction


# Setup the collision shape of the subject.
func setup_collision_shape(data: Dictionary)->void:
	if data.has("collision_shape"):
		Builder2D.add_collision_shape(self, data.collision_shape)


########################################################
# Methods                                              #
########################################################


func change_state(new_state : String)->void:
	current_state = new_state


func update_direction(new_direction : Vector2)->void:
	direction = new_direction
