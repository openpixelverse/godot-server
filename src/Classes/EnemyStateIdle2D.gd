extends State2D
class_name EnemyStateIdle2D


########################################################
# Variables                                            #
########################################################


var _ActionTimer : Timer


########################################################
# Hooks                                                #
########################################################


func _init(target: Node2D).(target):
	name = "Idle"


func _on_action_timer_timeout():
	emit_signal("finished", "wander")


########################################################
# Methods                                              #
########################################################


func enter():
	_ActionTimer = Timer.new()
	_ActionTimer.name = "ActionTimer"
	_ActionTimer.wait_time = rand_range(1, 3)
	_ActionTimer.autostart = true
	# warning-ignore:return_value_discarded
	_ActionTimer.connect("timeout", self, "_on_action_timer_timeout")
	add_child(_ActionTimer)


func exit():
	_ActionTimer.queue_free()
