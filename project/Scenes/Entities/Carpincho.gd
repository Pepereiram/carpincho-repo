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
export(PackedScene) var ProjectileA
export(PackedScene) var ProjectileB
onready var projectile_spawn = $Pivot/ProjSpawn
onready var timer = $Timer
onready var shootTimer = $ShootTimer
var shooting = false



func _ready():
	#activar arbol de animacion
	anim_tree.active = true

#aqui le metemos el arbol de animaciones 
func _physics_process(_delta):
	if shooting:
		velocity.x = 0
	else:
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
			timer.start(rand_range(3,6))
		if not shooting:
			if velocity.x == 0:
				#playback.travel("idle")
				pass
			elif velocity.x > 10:
				playback.travel("move_right")
			elif velocity.x < -10:
				playback.travel("move_left")


#death
func _death():
	playback.travel("explosion")
	

func _fire():
	var projectile = ProjectileA.instance()
	get_parent().add_child(projectile)
	projectile.global_position = projectile_spawn.global_position
	randomize()
	if self.global_position.x < 150:
		projectile.rotation = rand_range(PI/6,PI/3)
	elif self.global_position.x > 350:
		projectile.rotation = rand_range(4*PI/6,5*PI/6)
	else:
		projectile.rotation = rand_range(PI/6,2*PI/3)


func _on_Timer_timeout():
	#el carpunkcho ataca
	shooting = true
	shootTimer.start(1.5)
	playback.travel("attack_1")
	


func _on_AnimationPlayer_animation_finished(anim_name):
	pass # Replace with function body.


func _on_ShootTimer_timeout():
	_fire()
	shooting = false
