class_name NewPlayer
extends KinematicBody2D

# <----- Variables ----->

#movement
var velocity = Vector2()
var SPEED = 200
var ACCELERATION = 100
var GRAVITY = 10
var JUMP_SPEED = 180
#orientation
onready var pivot = $Pivot
#animation
onready var anim_player = $AnimationPlayer
onready var anim_tree = $AnimationTree
onready var playback = anim_tree.get("parameters/playback")
#Tip
onready var Tip = $Punta
onready var shoot_direction = $Pivot/direccionBala
onready var timer = $Timer
#Gun movement
var angle = 0
var ratio = 19
var potencia = 5
var new_position = Vector2(ratio, -3)
onready var gun = $Pivot/gun
onready var arm = $Pivot/arm
onready var power_part = $Pivot/direccionBala/Power
#states
var tip_attached = true 
var grabbed = false
var near_tip = true
#inputs
var right 
var left 
var jump
var fire 
var back 
var look_up
var look_down

# <----- Set up ----->

func _ready():
	anim_tree.active = true
	#Tip.deactivate_collision()
	Tip.get_node("cs").disabled = true
	Tip.get_node("Sprite").hide()

# <----- Every frame check the state ----->

func _process(delta):
	#
	if tip_attached: #jugador no ha lanzado la punta
		Tip.global_position = shoot_direction.global_position #punta se mantiene en spawn  
	if grabbed:
		grabbed_physics(delta)

	shoot_direction.position = new_position
		
	

# <----- Physics of the player ----->

#Fisicas del personaje
func _physics_process(delta):
	move_and_slide(velocity, Vector2.UP , false, 4, PI/4, false)
	#movimiento izquierda y derecha
	var move_input = Input.get_axis(left, right)
	velocity.x = move_toward(velocity.x, move_input*SPEED, ACCELERATION)
	velocity.y += GRAVITY
	if is_on_floor():
		velocity.y = 0
	#jumping:
	if is_on_floor() and Input.is_action_just_pressed(jump):
		velocity.y = -JUMP_SPEED
		
	#rotar sprite hacia los lados
	if Input.is_action_pressed(right) and not Input.is_action_pressed(left):
			pivot.scale.x = 1
	if Input.is_action_pressed(left) and not Input.is_action_pressed(right):
			pivot.scale.x = -1
	
	# ------- INPUT MANAGER ------------
	gun_input()
	#Ver caso a caso acciones del boton c
	_process_primary_button() 
	#Ver caso a caso acciones del boton b
	if Input.is_action_just_pressed(back):
		_process_secondary_button()
		
	# ------- Animations ------------

	if is_on_floor():
		if abs(velocity.x) > 0:
		
			playback.travel("run")
		else:
			playback.travel("idle")
	else:
		if velocity.y > 0:
			playback.travel("fall")
		elif velocity.y < 0:
			playback.travel("land")


#Fisicas personaje agarrado
func grabbed_physics(delta):
	velocity.y += 200 * delta
	var collision = move_and_collide(velocity * delta, false)
	if collision != null:
		_on_impact(collision)	
		
func _on_impact(collision):
	var normal = collision.normal
	velocity = velocity.bounce(normal)
	velocity *= 0.2 + rand_range(-0.02, 0.02)	
	
# <----- Process rod inputs ----->

func _process_primary_button():
	#LANZAR LA PUNTA
	#(si no he lanzado la punta aun) o (si la punta esta enganchada y cerca)
	if tip_attached or (near_tip and Tip.hooked):
		#lanzamiento
		if Input.is_action_pressed(fire):
			potencia += 0.4 #cargando
		if Input.is_action_just_released(fire):
			shoot() #soltando
	#TRAER DE VUELTA LA PUNTA		
	else:
		timer.is_stopped()
		if Input.is_action_just_pressed(fire) and timer.is_stopped():
			timer.start(1)
			retrieve() #traerlo devuelta
	#cambiar emiting de false a true y borrar particulas xd


#BOTON SECUANDARIO V
func _process_secondary_button():
	#SI ESTOY CERCA SE RECOGE LA PUNTA
	if near_tip:
		disconnect_tip()
	else:
		#SI ESTOY LEJOS Y LA PUNTA ESTA ENGANCHADA, ENTONCES
		#SE DEVUELVE 
		if Tip.hooked:
			disconnect_object()
			Tip.hooked = false
			#Tip.activate_collision()
			Tip.get_node("cs").disabled = false
			Tip.normal_launch()


# <----- Rod functionalities ----->

#Jugador lanza la punta
func shoot():
	if tip_attached:
		tip_attached = false
		#Tip.activate_collision()
		Tip.get_node("cs").disabled = false
		Tip.get_node("Sprite").show()	
		self.remove_child(Tip) #punta deja de ser hija del jugador
		get_parent().add_child(Tip) #punta es hija del escenario
		Tip.global_position = shoot_direction.global_position #punta se posiciona en su spawn   
	var orientation = pivot.scale.x
	var vel_vector = velocity_vector()
	Tip.launch2(vel_vector,orientation)
	potencia = 5

#Punta se devuelve hacia el jugador
func retrieve():
	Tip.launch(shoot_direction.global_position)#punta se mueve hacia el jugador

func disconnect_tip():
	if Tip.hooked:
		disconnect_object()
	#Tip.deactivate_collision()	
	Tip.get_node("cs").disabled = true
	Tip.get_node("Sprite").hide()#devuelve valores por defecto
	tip_attached = true #si la punta esta cerca jugador la recoge


func disconnect_object():
	Tip.hooked = false
	Tip.hb.grabbed = false 
	Tip.hb.set_physics_process(true)

func gun_input():
	#si se aprieta "q" la mira sube
	if Input.is_action_pressed(look_up) and shoot_direction.position.x > 0.1 :
		angle -= 0.1
		new_position.x = ratio * cos(angle) 
		new_position.y = ratio * sin(angle) - 3
		gun.rotation = angle 
		arm.rotation = angle 

	#si se aprieta "e" la mira baja
	elif Input.is_action_pressed(look_down) and shoot_direction.position.y < 0.3 :
		angle += 0.1
		new_position.x = ratio * cos(angle) 
		new_position.y = ratio * sin(angle) - 3
		gun.rotation = angle 
		arm.rotation = angle

func velocity_vector():

	var final_velocity = Vector2.ZERO
	if potencia > 15:
		potencia = 15
	final_velocity.x = potencia * new_position.x
	final_velocity.y = potencia * new_position.y

	return final_velocity
	
func set_near(value):
	near_tip = value
