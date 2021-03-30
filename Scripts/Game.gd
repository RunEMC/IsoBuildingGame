extends Node2D

var screenSize
var selectedCard = null


# Called when the node enters the scene tree for the first time.
func _ready():
	screenSize = get_viewport_rect().size
	print(screenSize)


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
			$TileMapOverlay.clearShadow()
			selectedCard = null


func _on_CardHolder_cardSelected(cardType):
	selectedCard = cardType
	print("Card selected: ", selectedCard)
