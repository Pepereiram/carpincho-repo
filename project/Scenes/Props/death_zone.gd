extends Area2D


func _ready():
	connect("body_entered",self,"on_body_entered")


func on_body_entered(body: Node):
	get_tree().reload_current_scene()
