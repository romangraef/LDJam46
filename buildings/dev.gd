extends BuildingInterface


var riot := preload("res://riot/riot.tscn")

func _tick() -> void:
	if SaveState.riot_cooldown == 0:
		SaveState.coffee -= get_amount()
		if SaveState.coffee < 0:
			invoke_riot()
			SaveState.coffee = 0
		else:
			SaveState.gain_bitcoin(get_amount())
	else:
		SaveState.riot_cooldown -= 1

func invoke_riot() -> void:
	SaveState.riot_cooldown = -1
	var mgt = find_parent('management')
	mgt.hide()
	mgt.pause_mode = PAUSE_MODE_STOP
	mgt.get_parent().add_child(riot.instance())
