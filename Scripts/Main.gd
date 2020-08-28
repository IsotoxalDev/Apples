extends Control

var gravity = 0
var time = 0
onready var scorelabel = $VBoxContainer/CenterContainer/HBoxContainer/Label2
onready var coinslabel = $VBoxContainer/CenterContainer2/HBoxContainer/Label2
onready var settingscn = preload("res://Scenes/Settings.tscn")
onready var SpritesScn = preload('res://Scenes/Sprites.tscn')
onready var container = $Container

func _ready():
	global.load()
	scorelabel.set_text(str(global.data['High Score']))
	coinslabel.set_text(str(global.data['Coins']))

func _process(_delta):
	time += 1
	if time == 35:
		spawn()
		time = 0

func spawn():
	var newSprite = SpritesScn.instance()
	var pos = Vector2(rand_range(12, 132), -20)
	newSprite.set_position(pos)
	#newSprite.set_applied_force(Vector2(newSprite.get_applied_force().x,newSprite.get_applied_force().y+gravity))
	container.add_child(newSprite)
	pass
		
func _on_Play_pressed():
	var _n = get_tree().change_scene('res://Scenes/Game.tscn')

func _on_Settings_pressed():
	for i in range(len(get_children())):
		get_child(i).hide()
	var settings =settingscn.instance()
	add_child(settings)

