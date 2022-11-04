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
#Rod
onready var Tip = $punta2
onready var tip_spawn = $Pivot/spawnBala
onready var shoot_direction = $Pivot/direccion2
onready var timer = $Timer
#states
var tip_attached = true 
var grabbed = false
var near_tip = true

# <----- Set up ----->

func _ready():
	anim_tree.active = true
	#Tip.get_node("cs").disabled = true
	Tip.get_node("Sprite").hide()

# <----- Every frame check the state ----->

func _process(delta):
	if tip_attached: #jugador no ha lanzado la punta
		Tip.global_position = shoot_direction.global_position #punta se mantiene en spawn  
	if grabbed:
		grabbed_physics(delta)

# <----- Physics of the player ----->

#Fisicas del personaje
func _physics_process(delta):
	move_and_slide(velocity, Vector2.UP , false, 4, PI/4, false)
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
	
	# ------- INPUT MANAGER ------------
	
	#Ver caso a caso acciones del boton c
	_process_primary_button() 
	#Ver caso a caso acciones del boton b
	if Input.is_action_just_pressed("soltar2"):
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
	near_tip = near_value()
	#LANZAR LA PUNTA
	#(si no he lanzado la punta aun) o (si la punta esta enganchada y cerca)
	if tip_attached or (near_tip and Tip.hooked):
		#lanzamiento
		if Input.is_action_pressed("lanzar2"):
			shoot_direction.potencia += 0.4 #cargando
		if Input.is_action_just_released("lanzar2"):
			shoot() #soltando
	#TRAER DE VUELTA LA PUNTA		
	else:
		timer.is_stopped()
		if Input.is_action_just_pressed("lanzar2") and timer.is_stopped():
			timer.start(1)
			retrieve() #traerlo devuelta


#BOTON SECUANDARIO V
func _process_secondary_button():
	near_tip = near_value()
	#SI ESTOY CERCA SE RECOGE LA PUNTA
	if near_tip:
		disconnect_tip()
	else:
		#SI ESTOY LEJOS Y LA PUNTA ESTA ENGANCHADA, ENTONCES
		#SE DEVUELVE 
		if Tip.hooked:
			disconnect_object()
			Tip.hooked = false
			Tip.get_node("cs").disabled = false
			retrieve()




# <----- Rod functionalities ----->

#Jugador lanza la punta
func shoot():
	if tip_attached:
		tip_attached = false
		Tip.get_node("cs").disabled = false
		Tip.get_node("Sprite").show()	
		self.remove_child(Tip) #punta deja de ser hija del jugador
		get_parent().add_child(Tip) #punta es hija del escenario
		Tip.global_position = shoot_direction.global_position #punta se posiciona en su spawn   
	var orientation = pivot.scale.x
	var vel_vector = shoot_direction.velocity_vector()
	Tip.launch2(vel_vector,orientation)
	shoot_direction.potencia = 5

#Punta se devuelve hacia el jugador
func retrieve():
	Tip.launch(shoot_direction.global_position)#punta se mueve hacia el jugador

func disconnect_tip():
	if Tip.hooked:
		disconnect_object()
	Tip.get_node("cs").disabled = true
	Tip.get_node("Sprite").hide()#devuelve valores por defecto
	tip_attached = true #si la punta esta cerca jugador la recoge


func disconnect_object():
	Tip.hooked = false
	Tip.hb.grabbed = false 
	Tip.hb.set_physics_process(true)

#FUNCION MUY POCO EFICIENTE, PROXIMAMENTE SE VA A CAMBIAR POR LA DETECCION DEL AREA
func near_value():
	var self_x = abs(Tip.global_position.x)
	var tip_x = abs( self.global_position.x) 
	var self_y = abs(Tip.global_position.y)
	var tip_y = abs( self.global_position.y) 
	var proximity_x = abs ( self_x - tip_x )
	var proximity_y = abs ( self_y - tip_y )
	return proximity_x < 20 and proximity_y < 20

func _on_Tip_detector_body_entered(body):
	pass
#	near_tip = true


func _on_Tip_detector_body_exited(body):
	pass
#	near_tip = false
