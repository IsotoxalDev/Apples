extends Area2D

var game = false

func _on_Ground_body_entered(body):
	match body.CSprite:
		'GoldApple':
			Player.play('Splat')
			if game: body.gamescn.life_down() 
		'PoisApple':
			Player.play('Splat')
			Score.start(body.get_position())
			if game: body.gamescn.score += 1
		'NormApple':
			Player.play('Splat')
			if game: body.gamescn.life_down()
		"Mangoes":
			Player.play("Splat")
			if game: body.gamescn.life_down()
		"Melon":
			Player.play("Splat")
			if game: body.gamescn.life_down()
		'Bomb':
			if game:
				body.camera.get_child(0).new_shake()
				body.set_gravity_scale(0)
				body.gamescn.score += 1
			else:	get_parent().get_node("Camera2D").get_child(0).new_shake()
			Player.play('Explode')
		"Increaser" or "Brake":
			Player.play('Splat')
	ParticlesManager.emit(body.CSprite, body.get_position())
	body.queue_free()
