extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const resourceLabelSuffix = "Count"
enum resources {
	wood,
	stone
}

func updateCount(res: String, amt: int) -> void:
#	Error check slow? take out in prod
#	if res in resources:
	var resCountPath = res + resourceLabelSuffix
	var countLabel = get_node(resCountPath)
	countLabel.text = String(int(countLabel.text) + amt)
#	else:
#		print_debug("[Error]: Invalid resource name '", res, "' not in ", resources)
		

func getCount(res: String) -> int:
	return int(get_node(res + resourceLabelSuffix).text)

# Called when the node enters the scene tree for the first time.
#func _ready():
#	updateCount("iron", 2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
