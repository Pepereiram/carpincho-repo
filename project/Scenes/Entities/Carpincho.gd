extends KinematicBody2D

var hp = 3
export var speed = 10
var acceleration = 50
var velocity = Vector2()
var direction = 1
#animations
onready var anim_player = $AnimationPlayer
onready var anim_tree = $AnimationTree
onready var playback = anim_tree.get("parameters/playback")



func _ready():
	#activar arbol de animacion
	anim_tree.active = true

#aqui le metemos el arbol de animaciones 
func _physics_process(_delta):
	
	velocity = move_and_slide(velocity)
	velocity.x = move_toward(velocity.x, direction*speed, acceleration)
	if is_on_wall():
		direction = direction * -1
		print(direction)
		print(velocity.x)
		position.x += direction
	#if hp == 0:
	#	playback.travel("explosion")
	if velocity.x == 0:
		playback.travel("idle")
	elif velocity.x > 0:
		print("derecha")
		playback.travel("move_right")
	else:
		print("izquierda")
		playback.travel("move_left")


#hacer esto cuando tengamos mas definido que wea

