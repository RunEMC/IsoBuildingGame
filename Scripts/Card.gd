extends Node2D

signal cardSelected(cardId, cardType)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var cardType = "dirt"
var mouseHovering = false
var selected = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("game_accept") and mouseHovering and not selected:
		emit_signal("cardSelected", get_instance_id(), cardType)
		selected = true

func getSize() -> Vector2:
	return $CardSprite.frames.get_frame("default", 0).get_size()

func deselectCard():
	selected = false
	
func setProperties(type: String) -> void:
	var types = $CardSprite.frames.get_animation_names()
	if type in types:
		cardType = type
		$CardSprite.animation = type
	else:
		print_debug("[Error]: Sprite card type not found: ", type)

func _on_Area2D_mouse_entered():
	mouseHovering = true


func _on_Area2D_mouse_exited():
	mouseHovering = false

