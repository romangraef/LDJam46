extends Node

var buildings = {
	"intern": 0,
	"dev": 1,
}
var upgrades = {
	"wageslavery": 0,
	"sunglasses": 0,
	"contract": 0,
}

func has_upgrade(name):
	return upgrades[name] > 0

func gain_bitcoin(amount: int) -> void:
	bitcoin += amount * (upgrades["wageslavery"] + 1)

func lose_bitcoin(amount: int) -> void:
	bitcoin -= amount 

func try_gain_coffee(amount: int) -> int:
	if amount < coffee_beans:
		coffee += amount
		coffee_beans -= amount
		return 0
	if has_upgrade("contract"):
		if try_buy_coffee_beans():
			return try_gain_coffee(amount)
	coffee += coffee_beans
	var remains = amount - coffee_beans
	coffee_beans = 0
	return remains

func try_buy_coffee_beans():
	var cost = int(100 * pow(0.9, upgrades['contract'] - 1) + 1)
	if bitcoin < cost:
		return false
	coffee_beans += 1000
	bitcoin -= cost
	return true


var coffee = 10
var coffee_beans = 100
var bitcoin = 10000
var riot_cooldown = 0

func pack_data():
	return {
		"buildings": buildings,
		"upgrades": upgrades,
		"coffee": coffee,
		"coffee_beans": coffee_beans,
		"bitcoin": bitcoin,
		"riot_cooldown": riot_cooldown,
	}
