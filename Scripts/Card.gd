extends Node2D

signal cardSelected(cardId)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var cardId: int
var cardName: String = "dirt"
var cardType: String = "tile"
var mouseHovering = false
var selected = false


# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.

func initCard(name, type):
	cardId = get_instance_id()
	cardName = name
	cardType = type
	$CardSprite.animation = name

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("game_accept") and mouseHovering and not selected:
		emit_signal("cardSelected", cardId)
		selected = true

func getSize() -> Vector2:
	return $CardSprite.frames.get_frame("default", 0).get_size()

func deselectCard() -> void:
	selected = false
	
#func setProperties(name:String, type: String) -> void:
#	var names = $CardSprite.frames.get_animation_names()
##	TODO: Remove and replace with try catch?
#	if name in names:
#		cardData.name = name
#		cardData.type = type
#		$CardSprite.animation = name
#	else:
#		print_debug("[Error]: Sprite card type not found: ", name)

func _on_Area2D_mouse_entered():
	mouseHovering = true


func _on_Area2D_mouse_exited():
	mouseHovering = false

