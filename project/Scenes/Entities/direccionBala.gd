extends Position2D

var angle = 0
var ratio = 10
var new_position = Vector2(ratio, 0.1)
var potencia = 0


func _process(delta):
	#posicion se actualiza cada frame
	position = new_position
	
	#si se aprieba "lanzar1" la mira cambia de posicion (cambia "potencia")
	if Input.is_action_pressed("lanzar1") :
		new_position.x = (ratio + potencia) * cos(angle)
		new_position.y = (ratio + potencia) * sin(angle)
	#si se aprieta "q" la mira sube
	elif Input.is_action_pressed("apuntar_arriba") and position.x > 0.1  :
		angle -= 0.1
		new_position.x = ratio * cos(angle)
		new_position.y = ratio * sin(angle)
	
	#si se aprieta "e" la mira baja
	elif Input.is_action_pressed("apuntar_abajo") and position.y <= 0 :
		angle += 0.1
		new_position.x = ratio * cos(angle)
		new_position.y = ratio * sin(angle)

func _changePot(val):
	potencia = val
