extends KinematicBody2D

var stop : bool = false
export var speed : int = 100

func _physics_process(_delta):
	if not stop:
		var pos = Vector2(Input.get_accelerometer().x, 0)
		move_and_slide(pos * speed)


func _on_Area2D_body_entered(body):
	match body.CSprite:
		'NormApple':
			Player.play('collect')
			Score.start(get_position())
			body.gamescn.score += 1
		'GoldApple':
			Player.play('collect')
			var amnt = int(rand_range(1, 10))
			body.gamescn.coins += amnt
			Score.coin(get_position(), amnt)
		'PoisApple':
			Player.play('loss')
			body.gamescn.life_down()
		'Bomb':
			Player.play('Explode')
			body.camera.get_child(0).new_shake()
			ParticlesManager.emit(body.CSprite, get_position())
			body.gamescn.life_end()
		'Brake':
			Player.play('collect')
			#print(get_gravity_scale())
			if body.get_gravity_scale() > 1:
				body.gamescn.gravity -= 0.3
		'Increaser':
			Player.play('collect')
			body.gamescn.gravity += 0.3
	body.Shrinktween.start()
