extends TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func placeTile(globalPosition: Vector2) -> void:
	var newCellPos = world_to_map(to_local(globalPosition))
	set_cellv(newCellPos, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
