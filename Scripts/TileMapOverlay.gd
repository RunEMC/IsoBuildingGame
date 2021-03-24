extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var prevShadowPos = null


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setTileShadow(globalPosition: Vector2) -> void:
	var newCellPos = world_to_map(to_local(globalPosition))
#	print(newCellPos)
	if prevShadowPos != newCellPos:
		if prevShadowPos != null:
			set_cellv(prevShadowPos, -1)
		set_cellv(newCellPos, 0)
		prevShadowPos = newCellPos
		
func clearShadow() -> void:
	if prevShadowPos != null:
		set_cellv(prevShadowPos, -1)
	prevShadowPos = null
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
