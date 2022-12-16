class_name Tip
extends KinematicBody2D

#Variables de movimiento
var velocity = Vector2(0,0)
const GRAVITY = 200
#Objeto agarrado
var hb = null
#estados
var on_air = false
var hooked = false
#posicion despues de agarrado
var dif = Vector2.ZERO
var attached_normal = Vector2.ZERO
#collision layer
var player_layer
var tip_layer
#collision body
var grabbed_object = null

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
	
	if layer == player_layer or layer == 32 and !hooked: #choque objeto "agarrable"
		#deactivate_collision()
		if !object_touched.grabbed:
			grabbed_object = object_touched
			object_touched.blue_outline()
			attached_normal = normal
			attach_pj(object_touched)
		else:
			velocity = velocity.bounce(normal)
			velocity *= 0.5 + rand_range(-0.05, 0.05)

	else: #choque paredes
		velocity = velocity.bounce(normal)
		velocity *= 0.5 + rand_range(-0.05, 0.05)

func attach_pj(hooked_object):
	self.get_node("cs").disabled = true #se desactivan colisiones punta
	
	dif = hooked_object.position - self.position 
	self.position = hooked_object.position + dif #punta se "pega" en el lugar donde choco
	hb = hooked_object #se guarda objeto chocado en una variable global
	hb.set_physics_process(false) #se desactivan fisicas normales del objeto
	hb.grabbed = true #con este estado objeto deberia tener fisicas de la caña
	hooked = true

# <----- Movement ----->

func launch2(new_velocity : Vector2, orientation):
	velocity = new_velocity
	velocity.x *= orientation
	if hooked:
		hb.velocity = velocity
	else:	
		set_physics_process(true)
	

#Lanzamiento de la punta
func launch(target_position : Vector2):
	var arc_height = target_position.y - global_position.y - 16
	arc_height = min(arc_height, - 16)
	calculate_arc_velocity(global_position,target_position,arc_height)		
	if !hooked:
		set_physics_process(true)
	else:
		hb.velocity = velocity
		

func normal_launch():
	velocity = 80 * attached_normal
	set_physics_process(true)
 
#Calculo velocidad inicial    
func calculate_arc_velocity(source_position,target_position,arc_height):
	var displacement = target_position - source_position
	if displacement.y > arc_height and arc_height < 0:
		var time_up = sqrt(-2* arc_height / float(GRAVITY))
		var time_down = sqrt(2 * (displacement.y - arc_height) / float(GRAVITY))
	
		velocity.y = -sqrt( -2 * GRAVITY * arc_height)
		velocity.x= displacement.x / float(time_up + time_down)
