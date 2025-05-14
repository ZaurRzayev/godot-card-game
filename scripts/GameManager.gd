extends Node

# UI references
@onready var player_hand_container = $UI/PlayerArea/HandContainer
@onready var ai_hand_container     = $UI/AIArea/AIHandContainer
@onready var player_hp_label       = $UI/PlayerArea/InfoContainer/HPLabel
@onready var player_skill_label    = $UI/PlayerArea/InfoContainer/SkillLabel
@onready var ai_hp_label           = $UI/AIArea/AIInfoContainer/AI_HPLabel
@onready var ai_skill_label        = $UI/AIArea/AIInfoContainer/AI_SkillLabel
@onready var end_turn_button       = $UI/PlayerArea/EndTurnButton

# Game state
var deck                = []
var player_deck         = []
var ai_deck             = []
var player_hp  : int    = 30
var ai_hp      : int    = 30
var player_skill : int  = 0
var ai_skill     : int  = 0
var player_turn   : bool = true
var played_legendary_this_turn = false
var player_effects : Array    = []
var ai_effects     : Array    = []
var card_cooldowns : Dictionary = {}

func _ready() -> void:
	randomize()

	# Build and shuffle decks
	deck = CardDB.cards.keys()
	player_deck = deck.duplicate()
	ai_deck     = deck.duplicate()
	player_deck.shuffle()
	ai_deck.shuffle()

	# Initial draw (7 cards each)
	draw_cards(player_deck, 7, player_hand_container)
	draw_cards(ai_deck,     7, ai_hand_container)

	# Connect End Turn button
	end_turn_button.pressed.connect(_on_end_turn)

	# Initialize UI and start first turn
	_update_ui()
	start_turn()

# Start a new turn for player or AI
func start_turn() -> void:
	played_legendary_this_turn = false

	if player_turn:
		# Player's turn
		player_skill = randi() % 10 + 1
		draw_cards(player_deck, 2, player_hand_container)
		end_turn_button.disabled = false
	else:
		# AI's turn
		ai_skill = randi() % 10 + 1
		draw_cards(ai_deck, 2, ai_hand_container)
		end_turn_button.disabled = true
		_ai_play()
		# Immediately end AI turn
		end_turn()

	_update_ui()

# Draw cards from deck into container
func draw_cards(deck_arr: Array, count: int, container: Node) -> void:
	for i in range(count):
		if deck_arr.is_empty():
			return
		var name = deck_arr.pop_back()
		# Enforce hand limit for player
		if container == player_hand_container and container.get_child_count() >= 7:
			var oldest = container.get_child(0)
			oldest.queue_free()
		# Instantiate card
		var card = preload("res://scenes/Card.tscn").instantiate() as Card
		card.setup(name)
		if container == player_hand_container:
			# Connect click and sacrifice signals
			card.connect("clicked", Callable(self, "_on_card_clicked").bind(card))
			card.connect("sacrifice", Callable(self, "_on_card_sacrificed").bind(card))
		container.add_child(card)

# Check if a card can be played (using its name for cooldown lookup)
func _can_play(data: Dictionary, name: String) -> bool:
	if data["cost"] > player_skill:
		return false
	if data["rarity"] == "Ultra Epic" and played_legendary_this_turn:
		return false
	if card_cooldowns.has(name) and card_cooldowns[name] > 0:
		return false
	return true

# Handle left-click on a card
func _on_card_clicked(card_node: Card) -> void:
	if not player_turn:
		return
	var name = card_node.card_name
	var data = CardDB.get_card_data(name)
	if data == null:
		return
	if not _can_play(data, name):
		print("Cannot play %s" % name)
		return
	_play_card(data, name, card_node)

# Handle right-click sacrifice
func _on_card_sacrificed(card_node: Card) -> void:
	var name = card_node.card_name
	var data = CardDB.get_card_data(name)
	if data == null:
		return
	if data["rarity"] == "Ultra Epic" and data["cost"] >= 13:
		print("Cannot sacrifice %s (too Legendary!)" % name)
		return
	player_skill += data["cost"]
	print("Sacrificed %s for %d Skill" % [name, data["cost"]])
	card_node.queue_free()
	_update_ui()

# Play a card and apply its effects
func _play_card(data: Dictionary, name: String, card_node: Card) -> void:
	# 1) Deduct cost & legendary flag
	player_skill -= data["cost"]
	if data["rarity"] == "Ultra Epic":
		played_legendary_this_turn = true

	# 2) Apply effect based on type
	match data["type"]:
		"Attack":
			ai_hp -= data["damage"]

		"Heal":
			player_hp = min(player_hp + data["heal"], 30)

		"Defense":
			player_effects.append({
				"name":  name,
				"type":  "Defense",
				"value": data.get("defense", 0),
				"turns": data["duration"]
			})

		"Buff":
			player_effects.append({
				"name":  name,
				"type":  "Buff",
				"value": data["damage"],
				"turns": data["duration"]
			})

		"Curse":
			ai_effects.append({
				"name":  name,
				"type":  "Curse",
				"value": data["damage"],
				"turns": data["duration"]
			})

		_:
			pass

	# 3) Register cooldown
	if data["cooldown"] > 0:
		card_cooldowns[name] = data["cooldown"]

	# 4) Remove the card from hand
	card_node.queue_free()

	# 5) Update UI & check for victory
	_update_ui()
	if ai_hp <= 0:
		_game_over("Player")

# Signal end of turn from button
func _on_end_turn() -> void:
	end_turn()

# End the current turn, switch sides, and start next
func end_turn() -> void:
	_process_end_of_turn()
	player_turn = not player_turn
	if player_hp <= 0:
		_game_over("AI")
		return
	start_turn()

# Effect ticking helper
func _tick_effects(effects: Array, is_player: bool) -> void:
	for eff in effects.duplicate():
		if eff["type"] == "Curse" and not is_player:
			player_hp -= eff["value"]
			print("Curse %s deals %d to Player" % [eff["name"], eff["value"]])
		eff["turns"] -= 1
		if eff["turns"] <= 0:
			if eff["type"] == "Defense":
				player_hp -= eff["value"]
				print("Defense %s expired (-%d HP)" % [eff["name"], eff["value"]])
			effects.erase(eff)

# Process end-of-turn effects and cooldowns
func _process_end_of_turn() -> void:
	if player_turn:
		_tick_effects(player_effects, true)
	else:
		_tick_effects(ai_effects, false)

	for name in card_cooldowns.keys():
		card_cooldowns[name] -= 1
		if card_cooldowns[name] <= 0:
			card_cooldowns.erase(name)

# Simple AI turn implementation
func _ai_play() -> void:
	for card in ai_hand_container.get_children():
		var data = CardDB.get_card_data(card.card_name)
		if data["type"] == "Attack" and data["cost"] <= ai_skill:
			ai_skill -= data["cost"]
			player_hp -= data["damage"]
			card.queue_free()
			print("AI played %s for %d damage" % [card.card_name, data["damage"]])
			_update_ui()
			break

# Update UI labels
func _update_ui() -> void:
	player_hp_label.text    = "HP: %d"    % player_hp
	player_skill_label.text = "Skill: %d" % player_skill
	ai_hp_label.text        = "HP: %d"    % ai_hp
	ai_skill_label.text     = "Skill: %d" % ai_skill

# Handle game over
func _game_over(winner: String) -> void:
	print("%s wins the game!" % winner)
