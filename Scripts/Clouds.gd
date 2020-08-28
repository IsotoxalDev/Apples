extends Node2D

var motion = 0
var direction = 0
export var speed = 5
onready var one = get_node('1')
onready var two = get_node('2')
onready var three = get_node('3')


func _ready():
	randomize()
	one.hide()
	two.hide()
	var cloud = rand_range(-1,1)
	if cloud < 0:
		one.show()
	elif cloud == 0:
		two.show()
	else:
		three.show()
func _process(delta):
	motion = direction*delta*speed
	set_position(get_position() + Vector2(motion, 0))
	if get_position().x < -150 or get_position().x > 220:
		queue_free()

