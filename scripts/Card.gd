extends Panel
class_name Card

signal clicked
signal sacrifice

@export var card_name: String = ""
@export var card_type: String = ""
@export var cost: int = 0
@export var damage: int = 0
@export var heal: int = 0
@export var defense: int = 0
@export var duration: int = 0
@export var rarity: String = ""
@export var cooldown: int = 0

func _ready():
	$Content/NameLabel.text  = card_name
	$Content/CostLabel.text  = "Cost: %d" % cost
	match card_type:
		"Attack":
			$Content/ValueLabel.text = "DMG: %d" % damage
		"Heal":
			$Content/ValueLabel.text = "Heal: %d" % heal
		"Defense":
			$Content/ValueLabel.text = "Def: %d (for %d turns)" % [defense, duration]
		"Buff":
			$Content/ValueLabel.text = "Buff (%d turns)" % duration
		"Curse":
			$Content/ValueLabel.text = "Curse (%d turns)" % duration
		_:
			$Content/ValueLabel.text = ""

func setup(name: String) -> void:
	var data = CardDB.get_card_data(name)
	if data == null:
		push_error("CardDB: no data for '%s'" % name)
		return
	card_name = name
	card_type = data.type
	cost      = data.cost
	damage    = data.damage
	heal      = data.heal
	defense   = data.get("defense", 0)
	duration  = data.duration
	rarity    = data.rarity
	cooldown  = data.cooldown
	_ready()


func _gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			emit_signal("clicked")
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			emit_signal("sacrifice")
