extends KinematicBody2D

#Variables de movimiento
var velocity = Vector2(0,0)
const GRAVITY = 200
#estados
var retrieved = false


#Punta comienza sin aplicarle fisicas
func _ready():
	set_physics_process(false)

#Fisicas mientras la punta vuela
func _physics_process(delta):    
	velocity.y += GRAVITY * delta
	var collision = move_and_collide(velocity * delta,false)
	if collision != null:
		_on_impact(collision)

#Que hacer cuando la punta impacta
func _on_impact(collision : KinematicCollision2D):
	var layer = collision.collider.get_collision_layer()
	if layer == 4 or layer == 33: 
		print("agarrar")
	else:
		var normal = collision.normal
		velocity = velocity.bounce(normal)
		velocity *= 0.5 + rand_range(-0.05, 0.05)
		print("rebote aca")	
		

#Lanzamiento de la punta
func launch(target_position : Vector2):
	var arc_height = target_position.y - global_position.y - 16
	calculate_arc_velocity(global_position,target_position,arc_height)
	set_physics_process(true)

#Estado para determinar el "tipo de trayectoria"*****
func set_retrieved(value : bool) :
	retrieved = value
	
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

