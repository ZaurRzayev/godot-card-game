extends Control

# Note: the CanvasLayer node is named "UI", so we start from $UI:
@onready var hand_container    = $UI/PlayerArea/HandContainer
@onready var end_turn_button   = $UI/PlayerArea/EndTurnButton

func _ready():
	# Test: spawn 5 random cards
	var names = CardDB.cards.keys()
	for i in 5:
		var name = names[randi() % names.size()]
		var c = preload("res://scenes/Card.tscn").instantiate() as Card
		c.setup(name)
		hand_container.add_child(c)

	# Wire up end-turn (this will come in Part 3)
	end_turn_button.pressed.connect(_on_end_turn)

func _on_end_turn():
	print("End Turn pressed")
