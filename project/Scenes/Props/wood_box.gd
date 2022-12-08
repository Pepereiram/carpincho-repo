extends KinematicBody2D

#variables
var velocity = Vector2(0,0)
const SPEED = 200
const ACCELERATION = 100
const GRAVITY = 200
#states
var grabbed = false
var on_air = false
#sprite
onready var sprite = $Sprite
#

func _process(delta):
	if grabbed:
		grabbed_physics(delta)
		
func _physics_process(delta):
	velocity.y += GRAVITY * delta
	var collision = move_and_collide(velocity * delta, false)
	if collision != null:
		_on_impact(collision)	


func grabbed_physics(delta):
	velocity.y += GRAVITY * delta
	var collision = move_and_collide(velocity * delta, false)
	if collision != null:
		_on_impact(collision)	
		
func _on_impact(collision):
	#print(collision.collider.get_layer_bit())
	var normal = collision.normal
	velocity = velocity.bounce(normal)
	velocity *= 0.2 + rand_range(-0.02, 0.02)			

#OUTLINE 
func red_outline():
	sprite.red_outline()
	
func blue_outline():
	sprite.blue_outline()

func delete_outline():
	sprite.delete_outline()
