extends Node2D
class_name SpawnArea2D


########################################################
# Member Variables                                     #
########################################################


var enemy_type: String
var max_enemies: int


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
	if get_child_count() < max_enemies:
		var enemy_data = OpenPixelverseAPI.load_enemy_data(enemy_type)
		var _Enemy = Enemy2D.new(enemy_data)
#		add_child(_Enemy)
