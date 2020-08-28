extends Node

var score = preload("res://Scenes/Score.tscn")
var coins = preload("res://Scenes/coins.tscn")

func start(pos =Vector2()):
	var Score = score.instance()
	Score.pos = pos
	add_child(Score)

func coin(pos, amnt = 0):
	var Coins = coins.instance()
	add_child(Coins)
	Coins.coin(amnt, pos)
	pass
