extends KinematicBody2D

var hp = 3
export var speed = 150
var acceleration = 50
var velocity = Vector2()
var direction = 1
#animations
onready var anim_player = $AnimationPlayer
onready var anim_tree = $AnimationTree
onready var playback = anim_tree.get("parameters/playback")
#projectile
onready var projectile_spawn = $Pivot/spawn
onready var timer = $Timer
var shooting = false



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
	if timer.is_stopped() and not shooting:
		randomize()
		timer.start(rand_range(4,6))
	if velocity.x == 0:
		playback.travel("idle")
	elif velocity.x > 0:
		playback.travel("move_right")
	else:
		playback.travel("move_left")


#death
func _death():
	playback.travel("explosion")
	
	pass


func _on_Timer_timeout():
	#el carpunkcho ataca
	shooting = true
	playback.travel("attack_1")
	pass # Replace with function body.


func _on_AnimationPlayer_animation_finished(anim_name):
	pass # Replace with function body.
