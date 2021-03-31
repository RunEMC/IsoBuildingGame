extends Node2D

var screenSize
var selectedCard = null
#Total weight will be calculated on ready, so don't need to make sure it's accurate
var nodeSpawnData = {
	"dirt": {
		"rates": [
			{
				"nodeType":"nothing",
				"spawnWeight": 1
			},
			{
				"nodeType":"rock",
				"spawnWeight": 1
			}
		],
#		"totalWeight": 1
	},
	"grass": {
		"rates": [
			{
				"nodeType":"nothing",
				"spawnWeight": 5
			},
			{
				"nodeType":"rock",
				"spawnWeight": 1
			},
			{
				"nodeType":"tree",
				"spawnWeight": 4
			}
		],
#		"totalWeight": 5
	}
}

# Called when the node enters the scene tree for the first time.
func _ready():
	screenSize = get_viewport_rect().size
	print(screenSize)
	
#	Calc spawn weights
	for tileType in nodeSpawnData:
		var tileDataNode = nodeSpawnData[tileType]
		var totalSpawnWeight = 0
		for rate in tileDataNode.rates:
			totalSpawnWeight += rate.spawnWeight
			rate.spawnWeight = totalSpawnWeight
		tileDataNode.totalWeight = totalSpawnWeight


func createNode(pos, type):
	var tileNodeData = nodeSpawnData[type]
	var totalSpawnWeight = tileNodeData.totalWeight
	randomize()
	var rng = randi() % totalSpawnWeight + 1
	for data in tileNodeData.rates:
		if rng <= data.spawnWeight and data.spawnWeight != null:
			print("rng: ", rng, "node ", data.nodeType)
			if data.nodeType != "nothing":
				$NodeMap.placeNode(pos, data.nodeType)
			return data


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mousePos = get_global_mouse_position()
		# Try to place new tile down
	if selectedCard and mousePos.y < 200:
#		Display overlay
		$TileMapOverlay.setTileShadow(mousePos)
#		Place Tile
		if Input.is_action_pressed("game_accept"):
			print("Mouse Click/Unclick at: ", mousePos)
			$CardHolder.deleteCard()
			$TileMap.placeTile(mousePos, selectedCard)
			createNode(mousePos, selectedCard)
			$TileMapOverlay.clearShadow()
			selectedCard = null


func _on_CardHolder_cardSelected(cardType):
	selectedCard = cardType
	print("Card selected: ", selectedCard)
