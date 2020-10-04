extends Button

export var type : String

func _on_Button_pressed():
	get_node("../../../Popups").show()
	get_node("../../../Popups/"+type+"buy").popup()
