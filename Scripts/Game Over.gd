extends Node2D

onready var scorelabel = $CenterContainer/VBoxContainer/CenterContainer/VBoxContainer/ScoreContainer/Label2
onready var coinslabel = $CenterContainer/VBoxContainer/CenterContainer/VBoxContainer/CoinsContainer/Label2
var score = global.score
var coins = global.coins

func _ready():
	if score > global.data['High Score']:
		global.data['High Score'] = score
	global.data['Coins'] = coins
	global.save()
	scorelabel.set_text(str(score))
	coinslabel.set_text(str(coins))
func _on_Button_pressed():
	var _n = get_tree().change_scene('res://Scenes/Game.tscn')


func _on_Button2_pressed():
	var _n = get_tree().change_scene('res://Scenes/Main.tscn')
	pass
