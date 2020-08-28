extends Control

onready var settingscn = preload("res://Scenes/Settings.tscn")

func _ready():
	hide()
	pass

func _on_Button_pressed():
	show()
	var paus = not get_tree().paused
	get_tree().paused = paus
	
func _on_Settings_pressed():
		for i in range(len(get_children())):
			get_child(i).hide()
		var settings =settingscn.instance()
		add_child(settings)
func _on_Resume_pressed():
	var paus = not get_tree().paused
	get_tree().paused = paus
	hide()


func _on_Menu_pressed():
	var paus = not get_tree().paused
	get_tree().paused = paus
	var _n = get_tree().change_scene('res://Scenes/Main.tscn')
	pass
