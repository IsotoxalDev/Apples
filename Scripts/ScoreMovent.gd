extends Control

var started = false
var fade = 1

class_name ScoreMovement

var pos = Vector2()

func _ready():
	set_position(pos)
	show()
	started = true

func _process(_delta):
	if get_position().y == -25:
		queue_free()
	if started:
		set_position(Vector2(get_position().x, get_position().y-1))
		set_modulate(Color(1,1,1,fade))
		if fade > 0:
			fade-=0.007
