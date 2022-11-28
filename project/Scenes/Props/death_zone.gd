extends Area2D


func _ready():
	connect("body_entered",self,"on_body_entered")


func on_body_entered(body: Node):
	if body.has_method("set_near"):
		get_tree().reload_current_scene()
