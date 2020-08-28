extends RigidBody2D

onready var Jiggletween = $JiggleTween
onready var Shrinktween = $ShrinkTween 
onready var appleSprite = $Apple
onready var bomb = $Bomb
onready var brake = $Brake
onready var increaser = $Increaser
onready var Mangoes = $Mangoes
onready var Melon = $Melon
onready var gamescn = get_node('../..')
onready var camera = gamescn.get_node("Camera2D")
const TRANS = Tween.TRANS_SINE
const EASE = Tween.EASE_IN_OUT
const DURATION = 0.2
var Sprites
var probablities
var maxpercent = 0
var temp = 0
var SpriteIndex = 0
var CSprite = ''
var basketPos = Vector2()

func _ready():
	global.load()
	Shrinktween.interpolate_property(self, "scale", get_scale(), Vector2.ZERO, DURATION, TRANS, EASE)
	Sprites = global.data["Sprites"]
	probablities = global.data["Probablities"]
	if get_node('../../').name == 'Game':
		if gamescn.score > 150:
			add_new("Brake", 2, 2)
	randomize()
	set_gravity_scale(get_gravity_scale()+gamescn.gravity)
	SpriteIndex = round(rand_range(0, 99))
	global.rand = SpriteIndex
	for i in range(len(probablities)):
		temp+=probablities[i]
		if SpriteIndex < temp:
			set_Sprite(Sprites[i])
			break
		pass


func set_Sprite(sprite):
	match sprite:
		'GoldApple':
			appleSprite.get_child(0).set_frame(2)
			appleSprite.show()
		'PoisApple':
			appleSprite.get_child(0).set_frame(1)
			appleSprite.show()
		'NormApple':
			appleSprite.get_child(0).set_frame(0)
			appleSprite.show()
		'Bomb':
			bomb.show()
		'Brake':
			brake.show()
		'Increaser':
			increaser.show()
		'Mangoes':
			Mangoes.show()
		'Melon':
			Melon.show()
	CSprite = sprite
	pass

func jiggleBack(body):
	Jiggletween.interpolate_property(body, "position", body.get_position, basketPos, DURATION/2, TRANS, EASE)
	Jiggletween.start()

func _on_Sprites_body_entered(body):
	if body.name == 'Ground':
		match CSprite:
			'GoldApple':
				Player.play('Splat')
				gamescn.life_down() 
			'PoisApple':
				Player.play('Splat')
				Score.start(get_position())
				gamescn.score += 1
			'NormApple':
				Player.play('Splat')
				gamescn.life_down()
			"Mangoes":
				Player.play("Splat")
				gamescn.life_down()
			"Melon":
				Player.play("Splat")
				gamescn.life_down()
			'Bomb':
				camera.get_child(0).new_shake()
				set_gravity_scale(0)
				Player.play('Explode')
				gamescn.score += 1
			"Increaser" or "Brake":
				Player.play('Splat')
		ParticlesManager.emit(CSprite, get_position())
		queue_free()
	elif body.name == 'Basket':
		basketPos = body.get_position()
		#Jiggletween.interpolate_property(body, "position", basketPos, basketPos+Vector2(0, 10), DURATION, TRANS, EASE)
		#Jiggletween.start()
		match CSprite:
			'NormApple':
				Player.play('collect')
				Score.start(get_position())
				gamescn.score += 1
			'GoldApple':
				Player.play('collect')
				var amnt = int(rand_range(1, 10))
				gamescn.coins += amnt
				Score.coin(get_position(), amnt)
			'PoisApple':
				Player.play('loss')
				gamescn.life_down()
			'Bomb':
				Player.play('Explode')
				camera.get_child(0).new_shake()
				ParticlesManager.emit(CSprite, get_position())
				gamescn.life_end()
			'Brake':
				Player.play('collect')
				#print(get_gravity_scale())
				if get_gravity_scale() > 1:
					gamescn.gravity -= 0.3
			'Increaser':
				Player.play('collect')
				gamescn.gravity += 0.3
				
		Shrinktween.start()
	pass


func _on_Sprites_mouse_entered():
	if CSprite == 'NormApple' or CSprite == 'GoldApple' or CSprite == 'PoisApple' or CSprite == "Melon" or CSprite == "Mangoes":
		Player.play('Splat')
		ParticlesManager.emit(CSprite, get_position())
		queue_free()
	elif CSprite == 'Bomb':
		gamescn.life_end()
		camera.get_child(0).new_shake()
		Player.play('Explode')
		ParticlesManager.emit(CSprite, get_position())
		queue_free()
	pass

func add_new(newVal, index, amnt):
	Sprites.append(newVal)
	probablities[index] -= amnt
	probablities.append(amnt)
	pass



func _on_ShrinkTween_tween_completed(object, key):
	queue_free()
