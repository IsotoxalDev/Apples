extends Control

var started = false
var value = 10
var time = 0
var coins = 1
onready var progress = $Progress
onready var coinslabel = $CenterContainer/HBoxContainer/coins
onready var coinsneed = $CenterContainer2/Label
onready var gamescn = get_node('../..')

func _ready():
	hide()
	pass

func start():
	show()
	time += 1
	coinslabel.set_text(str(global.coins))
	coins *= 10
	coinsneed.set_text(str(coins))
	started = true
	var timer = Timer.new()
	add_child(timer)
	timer.set_wait_time(10)
	timer.start()
	timer.connect("timeout", self, "timeout")

func _process(_delta):
	if started:
		progress.set_value(value/10*100)
		value = get_child(6).time_left
	
func timeout():
	get_child(6).stop()
	global.coins += gamescn.coins
	var _n = get_tree().change_scene("res://Scenes/Game Over.tscn")


func _on_Button_pressed():
	if global.coins > coins:
		global.coins -= coins
		started = false
		get_child(6).queue_free()
		hide()
		global.save()
		gamescn.Resume()
	pass

func _on_Button2_pressed():
	get_child(6).stop()
	global.coins += gamescn.coins
	var _n = get_tree().change_scene("res://Scenes/Game Over.tscn")
