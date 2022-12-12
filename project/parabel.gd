extends Node2D
var from = Vector2(20,20)
var to = Vector2(190,190)
var color = Color(255,255,255)

# Called when the node enters the scene tree for the first time.
func _ready():
	_draw()


func _draw():
	draw_line(from,to,color)
	from += Vector2(0,50)
	to += Vector2(0,50)
	pass
