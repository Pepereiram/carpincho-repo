extends KinematicBody2D


var velocity = Vector2()

var SPEED = 200
var ACCELERATION = 100
var GRAVITY = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	
	var move_input = Input.get_axis("move_left2", "move_right2")
	#velocity.x = move_input * SPEED
	velocity.x = move_toward(velocity.x, move_input*SPEED, ACCELERATION)
	velocity.y += GRAVITY * delta
	move_and_slide(velocity, Vector2.UP)
