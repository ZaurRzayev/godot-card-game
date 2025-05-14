# CardDatabase.gd
# A global singleton holding every card’s data.
extends Node
class_name CardDatabase

# Each entry: 
#   key = card name (String)
#   value = Dictionary of properties
var cards = {
	### Attack Cards ###
	"Swift Strike":      {"type":"Attack","damage":5,  "heal":0, "cost":3,  "rarity":"Common",   "cooldown":0, "duration":0},
	"Rapid Assault":     {"type":"Attack","damage":3,  "heal":0, "cost":2,  "rarity":"Common",   "cooldown":0, "duration":0},
	"Piercing Shot":     {"type":"Attack","damage":8,  "heal":0, "cost":5,  "rarity":"Rare",     "cooldown":0, "duration":0},
	"Jab":               {"type":"Attack","damage":4,  "heal":0, "cost":3,  "rarity":"Common",   "cooldown":0, "duration":0},
	"Crushing Blow":     {"type":"Attack","damage":10, "heal":0, "cost":6,  "rarity":"Rare",     "cooldown":0, "duration":0},
	"Frostbite":         {"type":"Attack","damage":6,  "heal":0, "cost":5,  "rarity":"Common",   "cooldown":0, "duration":0},
	"Poison Dart":       {"type":"Attack","damage":5,  "heal":0, "cost":5,  "rarity":"Common",   "cooldown":0, "duration":0},
	"Soul Devourer":     {"type":"Attack","damage":12, "heal":6, "cost":10, "rarity":"Epic",     "cooldown":0, "duration":0},
	"Omega Strike":      {"type":"Attack","damage":20, "heal":0, "cost":13, "rarity":"Ultra Epic","cooldown":0, "duration":0},
	"Doomsday":          {"type":"Attack","damage":30, "heal":0, "cost":15, "rarity":"Ultra Epic","cooldown":3, "duration":0},
	"Eclipse":           {"type":"Attack","damage":15, "heal":0, "cost":13, "rarity":"Ultra Epic","cooldown":3, "duration":0},
	"Infernal Blast":    {"type":"Attack","damage":8,  "heal":0, "cost":5,  "rarity":"Rare",     "cooldown":0, "duration":0},
	"Final Judgement":   {"type":"Attack","damage":10, "heal":0, "cost":5,  "rarity":"Common",   "cooldown":0, "duration":0},

	### Healing Cards ###
	"Minor Mend":        {"type":"Heal",  "damage":0,  "heal":5,  "cost":2,  "rarity":"Common",   "cooldown":0, "duration":0},
	"Healing Touch":     {"type":"Heal",  "damage":0,  "heal":10, "cost":5,  "rarity":"Rare",     "cooldown":0, "duration":0},
	"Nourishing Brew":   {"type":"Heal",  "damage":0,  "heal":6,  "cost":4,  "rarity":"Common",   "cooldown":0, "duration":0},
	"Healing Wave":      {"type":"Heal",  "damage":0,  "heal":15, "cost":6,  "rarity":"Epic",     "cooldown":0, "duration":0},
	"Regeneration":      {"type":"Heal",  "damage":0,  "heal":6,  "cost":5,  "rarity":"Common",   "cooldown":0, "duration":0},
	"Vampiric Embrace":  {"type":"Heal",  "damage":4,  "heal":4,  "cost":4,  "rarity":"Rare",     "cooldown":0, "duration":0},
	"Regenerative Burst":{"type":"Heal",  "damage":0,  "heal":20, "cost":10, "rarity":"Ultra Epic","cooldown":3, "duration":0},
	"Elixir of Immortality":{"type":"Heal","damage":0,  "heal":100,"cost":15, "rarity":"Ultra Epic","cooldown":3, "duration":0},
	"Phoenix Rebirth":   {"type":"Heal",  "damage":0,  "heal":50, "cost":15, "rarity":"Ultra Epic","cooldown":3, "duration":0},
	"Primordial Rebirth":{"type":"Heal",  "damage":0,  "heal":100,"cost":18, "rarity":"Ultra Epic","cooldown":3, "duration":0},
	"Eternal Blessing":  {"type":"Heal",  "damage":0,  "heal":50, "cost":13, "rarity":"Ultra Epic","cooldown":3, "duration":0},
	"Celestial Revival": {"type":"Heal",  "damage":0,  "heal":100,"cost":18, "rarity":"Ultra Epic","cooldown":3, "duration":0},

	### Defense Cards ###
	"Defensive Posture": {"type":"Defense","damage":0, "heal":0,  "cost":5,  "rarity":"Common",   "cooldown":0, "duration":1},
	"Turtle Shell":      {"type":"Defense","damage":0, "heal":0,  "cost":6,  "rarity":"Rare",     "cooldown":0, "duration":2},
	"Evasive Maneuver":  {"type":"Defense","damage":0, "heal":0,  "cost":8,  "rarity":"Epic",     "cooldown":0, "duration":2},
	"Stone Skin":        {"type":"Defense","damage":0, "heal":0,  "cost":5,  "rarity":"Common",   "cooldown":0, "duration":1},
	"Divine Shield":     {"type":"Defense","damage":0, "heal":0,  "cost":11, "rarity":"Epic",     "cooldown":3, "duration":2},
	"Temporal Rift":     {"type":"Defense","damage":0, "heal":0,  "cost":15, "rarity":"Ultra Epic","cooldown":3, "duration":3},
	"Spectral Sanctuary":{"type":"Defense","damage":0, "heal":0,  "cost":15, "rarity":"Ultra Epic","cooldown":3, "duration":3},
	"Chrono Barrier":    {"type":"Defense","damage":0, "heal":0,  "cost":12, "rarity":"Ultra Epic","cooldown":3, "duration":2},
	"Guardian's Embrace":{"type":"Defense","damage":0, "heal":0,  "cost":8,  "rarity":"Rare",     "cooldown":0, "duration":2},
	"Ethereal Shield":   {"type":"Defense","damage":0, "heal":0,  "cost":18, "rarity":"Ultra Epic","cooldown":3, "duration":3},

	### Buff Cards ###
	"Strength Potion":     {"type":"Buff","damage":0,"heal":0, "cost":5,  "rarity":"Common",   "cooldown":0, "duration":1},
	"War Cry":             {"type":"Buff","damage":0,"heal":0, "cost":5,  "rarity":"Common",   "cooldown":0, "duration":1},
	"Empower":             {"type":"Buff","damage":0,"heal":0, "cost":5,  "rarity":"Common",   "cooldown":0, "duration":1},
	"Blessing of Protection":{"type":"Buff","damage":0,"heal":0,"cost":8,  "rarity":"Rare",     "cooldown":0, "duration":2},
	"Battle Trance":       {"type":"Buff","damage":0,"heal":0, "cost":5,  "rarity":"Common",   "cooldown":0, "duration":1},
	"Dragon's Fury":       {"type":"Buff","damage":0,"heal":0, "cost":10, "rarity":"Ultra Epic","cooldown":3, "duration":2},
	"Avatar of Strength":  {"type":"Buff","damage":0,"heal":0, "cost":14, "rarity":"Ultra Epic","cooldown":3, "duration":3},
	"Blade Dance":         {"type":"Buff","damage":0,"heal":0, "cost":8,  "rarity":"Rare",     "cooldown":0, "duration":2},
	"Divine Intervention": {"type":"Buff","damage":0,"heal":0, "cost":12, "rarity":"Ultra Epic","cooldown":3, "duration":1},
	"Apocalypse":          {"type":"Buff","damage":0,"heal":0, "cost":16, "rarity":"Ultra Epic","cooldown":3, "duration":2},
	"Eternal Vigor":       {"type":"Buff","damage":0,"heal":0, "cost":13, "rarity":"Ultra Epic","cooldown":3, "duration":3},
	"Blessing of the Gods":{"type":"Buff","damage":0,"heal":0, "cost":5,  "rarity":"Common",   "cooldown":0, "duration":1},

	### Curse Cards ###
	"Hex":                {"type":"Curse","damage":0, "heal":0, "cost":4,  "rarity":"Common",   "cooldown":0, "duration":2},
	"Misfortune":         {"type":"Curse","damage":0, "heal":0, "cost":5,  "rarity":"Common",   "cooldown":0, "duration":2},
	"Enfeeble":           {"type":"Curse","damage":0, "heal":0, "cost":5,  "rarity":"Common",   "cooldown":0, "duration":2},
	"Curse of Frailty":   {"type":"Curse","damage":0, "heal":0, "cost":5,  "rarity":"Rare",     "cooldown":0, "duration":2},
	"Curse of Confusion": {"type":"Curse","damage":0, "heal":0, "cost":5,  "rarity":"Rare",     "cooldown":0, "duration":2},
	"Hex of the Abyss":   {"type":"Curse","damage":0, "heal":0, "cost":8,  "rarity":"Epic",     "cooldown":0, "duration":3},
	"Vitality Drain":     {"type":"Curse","damage":0, "heal":4, "cost":7,  "rarity":"Rare",     "cooldown":0, "duration":3},
	"Bloodthirsty Rampage":{"type":"Curse","damage":9,"heal":5, "cost":12, "rarity":"Ultra Epic","cooldown":3, "duration":1},
	"Eternal Oblivion":   {"type":"Curse","damage":18,"heal":0,"cost":18, "rarity":"Ultra Epic","cooldown":3, "duration":0},
	"Soul Drain":         {"type":"Curse","damage":0, "heal":8, "cost":8,  "rarity":"Rare",     "cooldown":0, "duration":2},
	"Death's Embrace":    {"type":"Curse","damage":0, "heal":10,"cost":15, "rarity":"Ultra Epic","cooldown":3, "duration":1}
}

func get_card_data(name: String) -> Dictionary:
	return cards.get(name, null)
