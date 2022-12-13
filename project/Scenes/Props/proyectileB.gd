extends "res://Scenes/Props/wood_box.gd"

func _on_impact(collision):
	if collision == null:
		#print(collision.collider.get_layer_bit())
		var normal = collision.normal
		velocity = velocity.bounce(normal)
		velocity *= 0.2 + rand_range(-0.02, 0.02)			
