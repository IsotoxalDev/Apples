extends Node2D

var currlife : int = 3
var score : int = 0
var coins :int = 0
export var nextspawn : int = 50
var time : int = 0
var a : int = 1
var first : bool = true
var stop : bool = false
var gravity : float = 0.1
var maxpercent : int = 0
var temp : int = 0
var Spawntime : int = 0
var SpritesScn : PackedScene = preload("res://Scenes/Sprites.tscn")
onready var container : CanvasLayer = $SpriteContainer
onready var scorelabel : Label = $UI/Score
onready var coinslabel : Label = $UI/Coins
onready var l1 : Node2D = $UI/Life/one
onready var l2 : Node2D = $UI/Life/two
onready var l3 : Node2D = $UI/Life/three
onready var revive_screen : Control = $Revive/Control

func _ready():
	$Ground.game = true

func _process(_delta):
	scorelabel.set_text(str(score))
	coinslabel.set_text(str(coins))
	time += 1
	if Input.is_action_just_pressed('god'):
		global.coins = 999999
	if not stop:
		if time == nextspawn:
			spawn()
			time = 0
			if score % 10 == 0:
				
				if first == true:
					if nextspawn != 30:
						nextspawn -= 1
					first = false
					gravity += 0.1
			else:
				first = true
	else:
		if not ParticlesManager.emmiting():
			if a == 1:
				revive_screen.start()
				for i in container.get_children():
					i.queue_free()
				a += 1
	

func spawn():
	var newSprite = SpritesScn.instance()
	var pos = Vector2(rand_range(12, 132), -35)
	newSprite.set_position(pos)
	container.add_child(newSprite)
	pass

func set_life(no):
	match no:
		3:
			l1.show()
			l2.show()
			l3.show()
		2:
			l1.show()
			l2.show()
			l3.hide()
		1:
			l1.show()
			l2.hide()
			l3.hide()
		0:
			l1.hide()
			l2.hide()
			l3.hide()
			global.score = score
			stop = true
	
func life_down():
	Input.vibrate_handheld(500)
	currlife -= 1
	set_life(currlife)
	var l = [l1, l2, l3]
	ParticlesManager.emit('Heart', l[currlife].get_position()-Vector2(5, 0))

func life_end():
	for _i in range(currlife):
		life_down()

func life_up():
	currlife += 1
	set_life(currlife)

func Resume():
	time = 0
	a = 1
	global.data['Coins'] = coins
	global.save()
	set_life(1)
	currlife = 1
	stop = false
func timeout():
	spawn()
	get_child(12).queue_free()
