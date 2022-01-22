extends Node2D
class_name SpawnArea2D


########################################################
# Member Variables                                     #
########################################################


var enemy_type : String
var max_enemies : int
var enemy_counter : int = 1 # We start at 1 and count up.
export var enemy_counter_reset : int = 1000


########################################################
# Signals                                              #
########################################################

signal spawn_enemy(spawn_position)


########################################################
# Hooks                                                #
########################################################


func _init(data: Dictionary)->void:
	setup_spawn_area(data)


func _on_Spawn_Timer_timeout()->void:
	emit_signal("spawn_enemy", global_position)
	spawn_enemy()


########################################################
# Setup                                                #
########################################################


# Setup the spawn point.
func setup_spawn_area(data: Dictionary)->void:
	setup_name(data)
	setup_position(data)
	setup_timer(data)
	setup_enemy(data)


# Setup the name of the spawn area.
func setup_name(data: Dictionary)->void:
	if data.has("name"):
		name = data.name


# Setup the position of the spawn area.
func setup_position(data: Dictionary)->void:
	assert(data.has("position"), "[SpawnArea2D] Validation Error: No position for spawn area provided.")
	position = data.position


# Setup the spawn timer.
func setup_timer(data: Dictionary)->void:
	assert(data.has("timer"), "[SpawnArea2D] Validation Error: No timer for spawn area provided.")
	assert(data.timer.has("interval"), "[SpawnArea2D] Validation Error: No timer interval for spawn area provided.")
	var _Timer = Timer.new()
	_Timer.name = "Spawn Timer"
	_Timer.wait_time = int(data.timer.interval)
	_Timer.autostart = true
	_Timer.connect("timeout", self, "_on_Spawn_Timer_timeout")
	add_child(_Timer)


# Setup the enemy associated with this spawn area.
func setup_enemy(data: Dictionary)->void:
	assert(data.has("enemy"), "[SpawnArea2D] Validation Error: No enemy provided.")
	assert(data.enemy.has("type"), "[SpawnArea2D] Enemy has no valid type.")
	assert(data.enemy.has("amount"), "[SpawnArea2D] Enemy has no valid amount.")
	enemy_type = data.enemy.type
	max_enemies = data.enemy.amount


########################################################
# Method                                               #
########################################################


# Spawn another enemy.
func spawn_enemy()->void:
	var child_count = get_child_count() - 1
	if child_count < max_enemies:
		var enemy_data = OpenPixelverseAPI.load_enemy_data(enemy_type)
		var _Enemy = Enemy2D.new(enemy_data)
		_Enemy.position = position
		
		# Set the name of this node.
		var enemy_name = enemy_type + " " + str(enemy_counter) + " (" + name + ")"
		_Enemy.name = enemy_name
		
		add_child(_Enemy)
		
		# Update the counter
		enemy_counter += 1
		if enemy_counter > enemy_counter_reset:
			enemy_counter = 1
			


# Get subject states of the enemies spawned by this spawn area.
func get_subject_states()->Dictionary:
	var subject_states = {}
	
	for _Enemy in get_children():
		# Only add enemy states (excluding eg. the timer).
		if _Enemy is Enemy2D:
			subject_states[_Enemy.name] = _Enemy.get_state()
	
	return subject_states


func get_subject_data(name)->Dictionary:
	var enemy_data : Dictionary
	
	if has_node(name):
		# TODO: Refactor this to actually load the data from the node.
		enemy_data = OpenPixelverseAPI.load_enemy_data(name)
		var _Enemy = get_node(name)
		enemy_data["scale_factor"] = _Enemy.scale
		enemy_data["position"] = _Enemy.global_position
	
	return enemy_data
