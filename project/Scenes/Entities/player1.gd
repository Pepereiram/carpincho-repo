class_name Player1
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
onready var anim_player = $Animation
onready var anim_tree = $AnimationTree
onready var playback = anim_tree.get("parameters/playback")
#Rod
onready var Tip = $Punta
onready var tip_spawn = $Pivot/spawnBala
onready var shoot_direction = $Pivot/direccionBala
#states
var tip_attached = true 
var grabbed = false

# <----- Set up ----->

func _ready():
	anim_tree.active = true
	Tip.get_node("cs").disabled = true
	Tip.get_node("Sprite").hide()

# <----- Every frame check the state ----->

func _process(delta):
	if tip_attached: #jugador no ha lanzado la punta
		Tip.global_position = tip_spawn.global_position #punta se mantiene en spawn  
	if grabbed:
		grabbed_physics(delta)

# <----- Physics of the player ----->

#Fisicas del personaje
func _physics_process(delta):
	move_and_slide(velocity, Vector2.UP , false, 4, PI/4, false)
	#movimiento izquierda y derecha
	var move_input = Input.get_axis("move_left", "move_right")
	velocity.x = move_toward(velocity.x, move_input*SPEED, ACCELERATION)
	velocity.y += GRAVITY
	if is_on_floor():
		velocity.y = 0
	#jumping:
	if is_on_floor() and Input.is_action_just_pressed("move_up"):
		velocity.y = -JUMP_SPEED
		
	#rotar sprite hacia los lados
	if Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
			pivot.scale.x = 1
	if Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
			pivot.scale.x = -1
	
	#acciones con la ""caña""
	if Input.is_action_just_pressed("lanzar1"):
		if tip_attached == true:
			shoot()    
		else:
			retrieve()
	if Input.is_action_just_pressed("soltar1"):
		
		if Tip.velocity.x != 0 and Tip.velocity.y != 0 : 
			print("hacer algo")
		else:
			retrieve()	

	# ------- Animations ------------
	"""
	if Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
		pivot.scale.x = 1
	if Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
		pivot.scale.x = -1
	"""
	if is_on_floor():
		if abs(velocity.x) > 0:
			playback.travel("run")
		else:
			playback.travel("idle")
	else:
		if velocity.y > 0:
			playback.travel("jump_asc")
		elif velocity.y < 0:
			playback.travel("jump_fall")

#Fisicas personaje agarrado
func grabbed_physics(delta):
	velocity.y += 200 * delta
	var collision = move_and_collide(velocity * delta, false)


# <----- Rod functionalities ----->

#Jugador lanza la punta
func shoot():
	Tip.get_node("cs").disabled = false
	Tip.get_node("Sprite").show()
	
	tip_attached = false
	Tip.retrieved = false
	self.remove_child(Tip) #punta deja de ser hija del jugador
	get_parent().add_child(Tip) #punta es hija del escenario
	Tip.global_position = tip_spawn.global_position #punta se posiciona en su spawn   
	Tip.launch(shoot_direction.global_position) #punta se lanza en direccion a la mira

#Punta se devuelve hacia el jugador
func retrieve():
	var self_x = abs(Tip.global_position.x)
	var tip_x = abs( self.global_position.x) 
	var proximity = abs ( self_x - tip_x )
	if proximity < 20:
		if Tip.hooked:
			disconnect_object()
		Tip.get_node("cs").disabled = true
		Tip.get_node("Sprite").hide()#devuelve valores por defecto
		tip_attached = true #si la punta esta cerca jugador la recoge
	else:    
		Tip.retrieved = true
		Tip.launch(self.global_position)#punta se mueve hacia el jugador

func disconnect_object():
	Tip.hooked = false
	Tip.hb.grabbed = false 
	Tip.hb.set_physics_process(true)
