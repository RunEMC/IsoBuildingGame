extends Node2D

export (PackedScene) var Card
export var cycleTime = 5
var cardsInHand = 0
var cardsLimit
var cardHolderSize
export var cardPadding = 10
var cardSize


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
#	pass

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
		
		print("Added ", cardType, " card at ", card.position)
		
	else:
		print("Hand full!")
		

func _on_Card_cardSelected(cardType):
	# Deal with card id here
	pass
	

func _on_Timer_timeout():
	addCardToHand("dirt")
	$DayTimer.start()
