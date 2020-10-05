extends Control

var to_scene : String
onready var timer : Timer = $Timer
onready var tween : Tween = $Tween
onready var color_rect : ColorRect = $ColorRect

func _goto(location : String):
	tween.interpolate_property(color_rect, "Color", Color(0,0,0,0), Color(0,0,0,1), 0.3, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	timer.start()


func _on_Timer_timeout():
	match to_scene:
		"MainMenu":
			pass
		"Game":
			pass
			
	tween.interpolate_property(color_rect, "Color", Color(0,0,0,0), Color(0,0,0,1), 0.3, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
