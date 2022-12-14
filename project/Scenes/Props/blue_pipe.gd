extends KinematicBody2D

#variables
var velocity = Vector2(0,0)
const SPEED = 200
const ACCELERATION = 100
const GRAVITY = 200
#states
var grabbed = false
var on_air = false

func _process(delta):
	if grabbed:
		grabbed_physics(delta)
		
func _physics_process(delta):
	move_and_slide(velocity, Vector2.UP , false, 4, PI/4, false)
	velocity.y += 10
	if is_on_floor():
		velocity.y = 0
		velocity.x = 0
		
func grabbed_physics(delta):
	velocity.y += GRAVITY * delta
	var collision = move_and_collide(velocity * delta, false)
	if collision != null:
		_on_impact(collision)	
		
func _on_impact(collision):
	#print(collision.collider)
	var normal = collision.normal
	velocity = velocity.bounce(normal)
	velocity *= 0.2 + rand_range(-0.02, 0.02)			
			
