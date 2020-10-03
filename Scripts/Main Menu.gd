extends Control

var gravity = 0
var time = 0
onready var settingscn = preload("res://Scenes/Settings.tscn")
onready var SpritesScn = preload('res://Scenes/Sprites.tscn')
onready var container = $"Apple Container"

func _ready():
	global.load()

func _process(_delta):
	time += 1
	if time == 35:
		spawn()
		time = 0

func spawn():
	var newSprite = SpritesScn.instance()
	var pos = Vector2(rand_range(12, 132), -20)
	newSprite.set_position(pos)
	container.add_child(newSprite)
	pass
