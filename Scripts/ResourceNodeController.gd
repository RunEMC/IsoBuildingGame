extends Node2D

signal resourceProduced(controllerId)
signal nodeExpired(nodePos)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var resource = "wood"
var timeToProduce = 1
var cyclesTillExpire = 5
var isInfinite = false
var resProducedPerCycle = 1
var nodePos

func initController(res, time, cycles, amt, pos):
	resource = res
	timeToProduce = time
	cyclesTillExpire = cycles
	if cyclesTillExpire <= 0:
		isInfinite = true
	resProducedPerCycle = amt
	nodePos = pos
	$NodeProductionTimer.wait_time = timeToProduce
	$NodeProductionTimer.start()
#	print("initiated with ", res, " ", time, " ", cycles, " ", amt, " ", pos)


# Called when the node enters the scene tree for the first time.
#func _ready():
#	initController("wood", 1, 1, 1, Vector2(1, 2))
#	$NodeProductionTimer.start()
#	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_NodeProductionTimer_timeout():
	var instId = get_instance_id()
	print("res: ", resource)
	emit_signal("resourceProduced", instId)
	cyclesTillExpire -= 1
	if !isInfinite and cyclesTillExpire <= 0:
		emit_signal("nodeExpired", instId)
		$NodeProductionTimer.stop()
	
	
