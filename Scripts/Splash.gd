extends Control


func _ready():
	var timer = Timer.new()
	add_child(timer)
	timer.set_wait_time(2)
	timer.start()
	timer.connect("timeout", self, 'timeout')
	pass

func timeout():
	var _n = get_tree().change_scene("res://Scenes/Main.tscn")
