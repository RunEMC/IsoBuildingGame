extends Node2D

signal cardSelected(cardType)

export (PackedScene) var Card
export var cycleTime = 5
var cardsInHand = 0
var cardsLimit
var cardHolderSize
export var cardPadding = 10
var cardSize
var selectedCardId = null
var cardsToMove = []
var cardData = [
	{
		"type": "dirt",
		"spawnWeight": 2
	},
	{
		"type": "grass",
		"spawnWeight": 1
	}
]
var totalSpawnWeight = 0


# Called when the node enters the scene tree for the first time.
func _ready(): 
	var card = Card.instance()
	cardSize = card.getSize()
	cardHolderSize = $CardHolderUI.texture.get_size()
	cardsLimit = floor(cardHolderSize.x/(cardSize.x + cardPadding))
	print_debug("Card limit: ", cardsLimit)
	
	$DayTimer.wait_time = cycleTime
	$DayTimer.start()

	for data in cardData:
		totalSpawnWeight += data.spawnWeight
		data.spawnWeight = totalSpawnWeight
	
	print_debug(cardData)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var i = 0
	for cardToMove in cardsToMove:
		var cardChild = cardToMove[0]
		var newPos = cardToMove[1]
		if cardChild != null and cardChild.position != newPos:
#			print("Moving child from ", cardChild.position, " to ", newPos)
			cardChild.position = cardChild.position.move_toward(newPos, delta * 80)
		else:
			if cardChild == null:
				print_debug("card doesnt exist at ", newPos)
#			else:
#				print_debug("Child reached destination", cardChild.position, newPos)
			cardsToMove.remove(i)
		i += 1

func setSize(width: int = cardHolderSize.x, height: int = cardHolderSize.y) -> void:
	$CardHolderUI.scale = Vector2(width/cardHolderSize.x, height/cardHolderSize.y)
	cardHolderSize = Vector2(width, height)

func addCardToHand(cardType: String) -> void:
	if cardsInHand < cardsLimit:
		var card = Card.instance()
		card.setProperties(cardType)
		card.position.x = cardPadding + ((cardSize.x + cardPadding) * cardsInHand) + floor(cardSize.x / 2)
		card.connect("cardSelected", self, "_on_Card_cardSelected")
		
		add_child(card)
		cardsInHand += 1
		
#		print_debug("Added ", cardType, " card at ", card.position)
		
	else:
		print_debug("Hand full!")
	
# Deletes selected card
func deleteCard():
	if selectedCardId != null:
		var inst = instance_from_id(selectedCardId)
		var instCoord = inst.position
#		print_debug("Deleted card ", selectedCardId, inst)
		selectedCardId = null
		inst.free()
		cardsInHand -= 1
#		Handle shfiting the rest of the cards over
		var children = get_children()
		for child in children:
			if (child.name.substr(1,4) == "Card" or child.name == "Card") and child.position.x > instCoord.x:
				var newChildPos = child.position
				newChildPos.x = newChildPos.x - cardSize.x - cardPadding
#				print_debug("Moving child from ", child.position, " to ", newChildPos)
#				child.position = position.move_toward(newChildPos, 1)
#				child.position = newChildPos
				cardsToMove.append([child, newChildPos])
					
				
		
func deselectCard():
	if selectedCardId != null:
		var inst = instance_from_id(selectedCardId)
		inst.deselectCard()
#		print_debug("Deselected ", selectedCardId, inst)
		selectedCardId = null
	
	
func _on_Card_cardSelected(cardId, cardType):
#	Deselect previous card
	if selectedCardId != cardId:
		deselectCard()
		
	selectedCardId = cardId
#	print_debug("Selected ", cardType, " card: ", cardId)
	emit_signal("cardSelected", cardType)
	
func spawnNewCard():
	randomize()
	var rng = randi() % totalSpawnWeight + 1
	for data in cardData:
		if rng <= data.spawnWeight and data.spawnWeight != null:
			addCardToHand(data.type)
			return data
	

func _on_Timer_timeout():
	spawnNewCard()
	$DayTimer.start()
