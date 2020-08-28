extends Node2D

onready var particle = $NormApple
onready var particle1 = $PoisApple
onready var particle2 = $GoldApple
onready var particle3 = $Heart
onready var particle4 = $Bomb
onready var particle5 = $Mango
onready var particle6 = $Melon

func emit(type, position):
	match type:
		'NormApple':
			particle.set_position(position)
			particle.set_emitting(true)
		"Increaser":
			particle.set_position(position)
			particle.set_emitting(true)
		"Brake":
			particle.set_position(position)
			particle.set_emitting(true)
		'PoisApple':
			particle1.set_position(position)
			particle1.set_emitting(not particle1.is_emitting())
		'GoldApple':
			particle2.set_position(position)
			particle2.set_emitting(not particle2.is_emitting())
		'Heart':
			particle3.set_position(position)
			particle3.set_emitting(true)
		'Bomb':
			Input.vibrate_handheld(750)
			particle4.set_position(position)
			particle4.set_emitting(true)
		"Mangoes":
			particle5.set_position(position)
			particle5.set_emitting(true)
		"Melon":
			particle6.set_position(position)
			particle6.set_emitting(true)

func emmiting():
	return (particle.is_emitting() or  
	particle1.is_emitting() or particle2.is_emitting() or 
	particle3.is_emitting() or particle4.is_emitting() or
	particle5.is_emitting() or particle6.is_emitting())
