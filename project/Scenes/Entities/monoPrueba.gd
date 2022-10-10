extends KinematicBody2D

#Variables movimiento
var velocity = Vector2()
var SPEED = 200
var ACCELERATION = 100
var GRAVITY = 10
var JUMP_SPEED = 200

onready var pivot = $Pivot


#Variables caña
onready var Tip = $Punta
onready var tip_spawn = $Pivot/spawnBala
onready var shoot_direction = $Pivot/direccionBala
var tip_attached = true #es un estado


func _process(delta):
	if tip_attached == true: #jugador no ha lanzado la punta
		Tip.global_position = tip_spawn.global_position #punta se mantiene en spawn  

#Fisicas del personaje
func _physics_process(delta):
	move_and_slide(velocity, Vector2.UP)
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
	if Input.is_action_pressed("lanzar1"):
		if tip_attached == true:
			#comenzar un timer interno para que la mira (potencia) varie en el tiempo
			# setPotencia(+1)
			shoot()    
		else:
			retrieve()

#Jugador lanza la punta
func shoot():
	tip_attached = false
	Tip.set_retrieved(false)
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
		tip_attached = true #si la punta esta cerca jugador la recoge
	else:    
		Tip.set_retrieved(true)
		Tip.launch(self.global_position)#punta se mueve hacia el jugador
	
