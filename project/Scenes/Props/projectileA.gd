extends Area2D


var velocity = Vector2()
var GRAVITY = 500
var SPEED = 200

func _ready():
	pass
	
func _physics_process(delta):
	velocity.x += 200
	velocity.y += GRAVITY*delta
	pass
