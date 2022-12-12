extends Area2D

var SPEED = 150
	
func _physics_process(delta):
	position += SPEED * transform.x * delta


func _on_ProjectileA_body_entered(body):
	queue_free()
	if body.has_method("player_death"):
		body.set_physics_process(false)
		#yield(body.player_death(), "hola")
		Fade.reload_scene()
