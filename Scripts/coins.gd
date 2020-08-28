extends Control

export (Texture) var txture = null
var amt = 0
var cur = 0
var pos = Vector2()
var coinscn = preload("res://Scenes/coin.tscn")

func coin(amnt, posit):
	amt = amnt
	pos = posit
	var t = Timer.new()
	var Coin = coinscn.instance()
	Coin.pos = pos
	add_child(Coin)
	cur+=1
	t.set_wait_time(0.5)
	t.connect("timeout",self,"timeout")
	add_child(t)
	t.start()
	pass


func timeout():
	if amt >= cur:
		var Coin = coinscn.instance()
		Coin.pos = pos
		add_child(Coin)
		cur+=1
	else:
		cur=0
		queue_free()
