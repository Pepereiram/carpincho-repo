extends Area2D

var hp = 3


func _ready():
	#activar arbol de animacion
	pass


#aqui le metemos el arbol de animaciones 
func _process(delta):
	if hp == 0:
		print("animacion de muerte") 
	pass

#hacer esto cuando tengamos mas definido que wea
func _on_Carpincho_body_entered(body):
	#objeto desaparece
	body.queue_free()
	#se reduce en 1 la vida 
	hp-=1

