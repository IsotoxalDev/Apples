extends Node

onready var Collect = $Collect
onready var Loss = $Loss
onready var Splat= $Splat
onready var bg = $BG
onready var explode = $Explode
var t = 0

func play(media):
	if global.data['music']:
		if media == 'collect':
			Collect.play()
		elif media == 'loss':
			Loss.play()
		elif media == 'Splat':
			Splat.play()
		elif media == 'Explode':
			explode.play()

func _ready():
	global.load()
	if global.data['music']:
		var timer = Timer.new()
		add_child(timer)
		timer.set_wait_time(2)
		timer.start()
		timer.connect('timeout', self, '_timeout')

func _timeout():
	if global.data['music']:
		get_child(5).stop()
		bg.play()

func music():
	if global.data['music']:
		bg.play()
	if not global.data['music']:
		bg.stop()

