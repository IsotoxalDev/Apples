extends Node

var amplitude = 3
var duration = 5
var count = 0
var active = false
const TRANS = Tween.TRANS_SINE
const EASE = Tween.EASE_IN_OUT
onready var shakeTween = $ShakeTween
onready var resetTween = $ResetTween
onready var camera = get_parent()

func new_shake():
	randomize()
	if !active:
		if count <= duration:
				active = true
				count+=1
				var final_val = Vector2(rand_range(-amplitude, amplitude), rand_range(-amplitude, amplitude))
				var frequency = rand_range(0, 0.2)
				shakeTween.interpolate_property(camera, "offset", camera.offset, final_val, frequency, TRANS, EASE)
				shakeTween.start()
		else:
			resetTween.interpolate_property(camera, "offset", camera.offset, 0, .2, TRANS, EASE)
			resetTween.start()
			active = false
			count = 0



func _on_ShakeTween_tween_completed(object, key):
	active = false
	new_shake()
