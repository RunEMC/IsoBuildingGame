extends TileMap

signal removeCard()
# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


func placeTile(globalPosition: Vector2, tileType: String) -> void:
	var newCellPos = world_to_map(to_local(globalPosition))
	var cellId = tile_set.find_tile_by_name(tileType + "Tile")
	print_debug("Placing tile ", tileType)
	set_cellv(newCellPos, cellId)
	emit_signal("removeCard")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
