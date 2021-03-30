extends TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	print(tile_set.tile_get_name(0))
	pass # Replace with function body.


func placeTile(globalPosition: Vector2, tileType: String) -> void:
	var newCellPos = world_to_map(to_local(globalPosition))
	var cellId = tile_set.find_tile_by_name(tileType + "Tile")
	print_debug("Found tile ", cellId)
	set_cellv(newCellPos, cellId)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
