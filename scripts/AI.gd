extends PlayerNode
class_name AINode

func play_turn(opponent):
	played_legendary = false
	# 1) Lethal?
	for c in hand:
		if c.card_type == "Attack" and c.damage >= opponent.hp and c.cost <= skill_points:
			_play(c, opponent)
			return
	# 2) Heal if low...
	if hp <= 10:
		for c in hand:
			if c.card_type == "Heal" and c.cost <= skill_points:
				_play(c, self)
				break
	# 3) Buff...
	# 4) Curse...
	# 5) Attack with highest damage...
	# 6) Defense if nothing else
	end_turn()
func _play(c, target):
	# duplicate same logic as GameManager.play_card
	# deduct cost, apply effect...
	pass
