extends Node
class_name PlayerNode

var deck = []        # will hold dictionaries of card data
var hand = []        # holds instantiated Card nodes
var hp: int = 30
var skill_points: int = 0
var played_legendary: bool = false
var defense: int = 0

func setup_deck(card_data):
	deck = card_data.duplicate()
	deck.shuffle()

func draw_cards(n):
	for i in n:
		if deck.empty():
			break
		var cinfo = deck.pop_back()
		var c = preload("res://scenes/Card.tscn").instantiate() as Card
		c.card_name = cinfo.name
		c.card_type = cinfo.type
		c.cost = cinfo.cost
		c.damage = cinfo.damage
		c.heal = cinfo.heal
		c.duration = cinfo.duration
		c.rarity = cinfo.rarity
		add_to_hand(c)
func add_to_hand(card):
	if hand.size() >= 7:
		# discard logic here (prompt or random)
		return
	hand.append(card)
	get_node("/root/Main/UI/PlayerArea/HandContainer").add_child(card)
