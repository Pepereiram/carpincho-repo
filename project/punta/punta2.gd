class_name punta2
extends KinematicBody2D

#Variables de movimiento
var velocity = Vector2(0,0)
const GRAVITY = 200
#Objeto agarrado
var hb = null
#estados
var retrieved = false
var hooked = false
#posicion despues de agarrado
var dif = Vector2.ZERO

# <----- Set up ----->

func _ready():
	set_physics_process(false)

# <----- Every Frame ----->

func _process(delta):
	if hooked:
		self.position = hb.position - dif #posicion de la punta sigue al objeto
										  #agarrado en movimiento

# <----- Tip physics ----->

func _physics_process(delta):    
	velocity.y += GRAVITY * delta
	var collision = move_and_collide(velocity * delta, false)
	if collision != null:
		_on_impact(collision)

# <----- collisions ----->

func _on_impact(collision):
	var object_touched = collision.collider
	var normal = collision.normal
	var layer = object_touched.get_collision_layer()
	
	if layer == 2 or layer == 32 and !hooked: #choque objeto "agarrable"
		attach_pj(object_touched,normal)

	else: #choque paredes
		velocity = velocity.bounce(normal)
		velocity *= 0.5 + rand_range(-0.05, 0.05)

func attach_pj(hooked_object,normal):
	self.get_node("cs").disabled = true #se desactivan colisiones punta
	dif = hooked_object.position - self.position 
	self.position = hooked_object.position + dif #punta se "pega" en el lugar donde choco
	hb = hooked_object #se guarda objeto chocado en una variable global
	hb.set_physics_process(false) #se desactivan fisicas normales del objeto
	hb.grabbed = true #con este estado objeto deberia tener fisicas de la caña
	hooked = true

# <----- Movement ----->

#Lanzamiento de la punta
func launch(target_position : Vector2):
	var arc_height = target_position.y - global_position.y - 16
	calculate_arc_velocity(global_position,target_position,arc_height)
	if !hooked:
		set_physics_process(true)
	else:
		hb.velocity = self.velocity #se le da la velocidad de la punta al objeto
									#agarrado
 
#Calculo velocidad inicial    
func calculate_arc_velocity(source_position,target_position,arc_height):
	var displacement = target_position - source_position
	
	if displacement.y > arc_height and arc_height < 0:
		var time_up = sqrt(-2* arc_height / float(GRAVITY))
		var time_down = sqrt(2 * (displacement.y - arc_height) / float(GRAVITY))
	
		velocity.y = -sqrt( -2 * GRAVITY * arc_height)
		#el trucazo por accidente...
		if retrieved == true:
			velocity.x= displacement.x / float(time_up + time_down)
		else:    
			velocity.x= displacement.x / float(time_up - time_down)    
			
