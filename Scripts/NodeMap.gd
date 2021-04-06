extends TileMap

signal removeCard()
# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.

var buildingsData = {
	"lumber": {
		"requiredNode": "tree",
		"produces": "wood"
	},
	"mine": {
		"requiredNode": "rock",
		"produces": "stone"
	}
}

func placeNode(globalPosition: Vector2, tileType: String) -> void:
	var newCellPos = world_to_map(to_local(globalPosition)+ position)
	var cellId = tile_set.find_tile_by_name(tileType + "Node")
#	print_debug("Placing node ", tileType, " with id ", cellId)
	set_cellv(newCellPos, cellId)
	
func buildOverNode(globalPosition: Vector2, building: String):
	var newCellPos = world_to_map(to_local(globalPosition)+ position)
	var cellId = get_cellv(newCellPos)
	if cellId != -1:
		var tileName = tile_set.tile_get_name(cellId).trim_suffix("Node")
		var buildingData = buildingsData[building]
		if buildingData.requiredNode == tileName:
			cellId = tile_set.find_tile_by_name(building)
			set_cellv(newCellPos, cellId)
			emit_signal("removeCard")
#			Change this to proper data type with actual production values
			return {
				"cellPos": newCellPos,
				"resource": buildingData.produces
			}
	return null
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
