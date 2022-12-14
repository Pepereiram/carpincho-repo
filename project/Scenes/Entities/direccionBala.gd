extends Position2D

var angle = 0
var ratio = 10
var potencia = 5
var new_position = Vector2(ratio, 0)

func _process(delta):
	#posicion se actualiza cada frame
	position = new_position
	
	#si se aprieta "q" la mira sube
	if Input.is_action_pressed("apuntar_arriba") and position.x > 0.1  :
		angle -= 0.1
		new_position.x = ratio * cos(angle)
		new_position.y = ratio * sin(angle)
	
	#si se aprieta "e" la mira baja
	elif Input.is_action_pressed("apuntar_abajo") and position.y <= 0 :
		angle += 0.1
		new_position.x = ratio * cos(angle)
		new_position.y = ratio * sin(angle)

func velocity_vector():

	var final_velocity = Vector2.ZERO
	if potencia > 30:
		potencia = 30
	final_velocity.x = potencia * new_position.x
	final_velocity.y = potencia * new_position.y

	return final_velocity
