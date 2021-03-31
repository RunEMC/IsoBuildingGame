extends TileMap

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


func placeNode(globalPosition: Vector2, tileType: String) -> void:
	var newCellPos = world_to_map(to_local(globalPosition)+ position)
	var cellId = tile_set.find_tile_by_name(tileType + "Node")
	print_debug("Placing node ", tileType, " with id ", cellId)
	set_cellv(newCellPos, cellId)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
