extends KinematicBody2D

#variables movimiento
var velocity = Vector2()
var SPEED = 200
var ACCELERATION = 100
var GRAVITY = 10
var JUMP_SPEED = 200
#orientacion
onready var pivot = $Pivot


func _physics_process(delta):
	move_and_slide(velocity, Vector2.UP)
	#movimiento izquierda y derecha
	var move_input = Input.get_axis("move_left2", "move_right2")
	velocity.x = move_toward(velocity.x, move_input*SPEED, ACCELERATION)
	velocity.y += GRAVITY
	if is_on_floor():
		velocity.y = 0
	#jumping:
	if is_on_floor() and Input.is_action_just_pressed("move_up2"):
		velocity.y = -JUMP_SPEED
	#rotar sprite hacia los lados
	if Input.is_action_pressed("move_right2") and not Input.is_action_pressed("move_left"):
			pivot.scale.x = 1
	if Input.is_action_pressed("move_left2") and not Input.is_action_pressed("move_right"):
			pivot.scale.x = -1	
