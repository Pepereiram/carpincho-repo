extends Position2D

var angle = 0
var ratio = 15
var new_position = Vector2(ratio, 0.1)

func _process(delta):
	#posicion se actualiza cada frame
	position = new_position
	
	#si se aprieta "q" la mira sube
	if Input.is_action_pressed("apuntar_arriba2") and position.x > 0.1  :
		angle -= 0.1
		new_position.x = ratio * cos(angle)
		new_position.y = ratio * sin(angle)
	
	#si se aprieta "e" la mira baja
	elif Input.is_action_pressed("apuntar_abajo2") and position.y <= 0 :
		angle += 0.1
		new_position.x = ratio * cos(angle)
		new_position.y = ratio * sin(angle)
