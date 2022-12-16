extends "res://Scenes/Props/wood_box.gd"


func _on_impact(collision):
	var object_touched = collision.collider
	var normal = collision.normal
	var layer = object_touched.get_collision_layer()
	if layer == 1:
		velocity = velocity.bounce(normal)
		velocity *= 0.2 + rand_range(-0.02, 0.02)
	else:
		if object_touched.has_method("death"):
			object_touched.death()
