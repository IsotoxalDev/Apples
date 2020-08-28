extends Control

onready var parentscn = get_node("..")
onready var checkbox = $CenterContainer/VBoxContainer/CheckBox

func _ready():
	checkbox.set_pressed(global.data['music'])


func _on_CheckBox_pressed():
	global.data['music'] = not global.data['music']
	Player.music()
	global.save()

func _on_Button_pressed():
	for i in range(len(parentscn.get_children())):
		parentscn.get_child(i).show()
	queue_free()
