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


# Called when the node enters the scene tree for the first time.
func _ready(): 
	var card = Card.instance()
	cardSize = card.getSize()
	cardHolderSize = $CardHolderUI.texture.get_size()
	cardsLimit = floor(cardHolderSize.x/(cardSize.x + cardPadding))
	print("Card limit: ", cardsLimit)
	
	$DayTimer.wait_time = cycleTime
	$DayTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):

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
		
		print_debug("Added ", cardType, " card at ", card.position)
		
	else:
		print_debug("Hand full!")
	
# Deletes selected card
func deleteCard():
	if selectedCardId != null:
		var inst = instance_from_id(selectedCardId)
		print_debug("Deleted card ", selectedCardId, inst)
		selectedCardId = null
		inst.free()
		cardsInHand -= 1
#		Handle shfiting the rest of the cards over
	
		
func deselectCard():
	if selectedCardId != null:
		var inst = instance_from_id(selectedCardId)
		inst.deselectCard()
		print_debug("Deselected ", selectedCardId, inst)
		selectedCardId = null
	
func _on_Card_cardSelected(cardId, cardType):
#	Deselect previous card
	if selectedCardId != cardId:
		deselectCard()
		
	selectedCardId = cardId
#	print_debug("Selected ", cardType, " card: ", cardId)
	emit_signal("cardSelected", cardType)
	

func _on_Timer_timeout():
	addCardToHand("dirt")
	$DayTimer.start()
