extends Node2D

var currlife = 3
var score = 0
var coins = 0
export var nextspawn = 50
var time = 0
var a = 1
var first = true
var stop = false
var gravity = 0.1
var SpawnLabel = [1, 2, 3]
var probablities = [70, 25, 5]
var spawnrate = 0
var maxpercent = 0
var temp = 0
var Spawntime = 0
var SpritesScn = preload("res://Scenes/Sprites.tscn")
export var speed = 100
onready var basket = $Basket
onready var basketcol = $basketcol2
onready var container = $SpriteContainer
onready var scorelabel = $UI/Score
onready var coinslabel = $UI/Coins
onready var l1 = $UI/Life/one
onready var l2 = $UI/Life/two
onready var l3 = $UI/Life/three
onready var revive_screen = $Revive/Control

#func _ready():
	#if global.data['music']:
	#	bg.play()

func _process(_delta):
	scorelabel.set_text(str(score))
	coinslabel.set_text(str(coins))
	time += 1
	if Input.is_action_just_pressed('god'):
		global.coins = 999999
	if not stop:
		if time == nextspawn:
			for i in probablities:
				maxpercent += i
			spawnrate = rand_range(0, maxpercent)
			for j in range(len(probablities)):
				temp += probablities[j]
				if spawnrate < temp:
					for _i in range(SpawnLabel[j]):
						spawn()
					break
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
				#	ParticlesManager.emit(i.Sprite, i.get_position())
					i.queue_free()
				a += 1
	


func _physics_process(_delta):
	if not stop:
		#var pos = Vector2(get_viewport().get_mouse_position().x, 180)
		var pos = Vector2(Input.get_accelerometer().x, 0)
		#basket.set_position(pos)
		#basketcol.set_position(pos)
		basket.move_and_slide(pos * speed)
		basketcol.set_position(pos * speed)
	pass

func spawn():
	var newSprite = SpritesScn.instance()
	var pos = Vector2(rand_range(12, 132), -35)
	newSprite.set_position(pos)
	#newSprite.set_applied_force(Vector2(newSprite.get_applied_force().x,newSprite.get_applied_force().y+gravity))
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
