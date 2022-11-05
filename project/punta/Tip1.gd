class_name Tip1
extends "res://punta/Tip.gd"

func _init():
	player_layer = 4
	tip_layer = 8


func _on_Tip_detector_body_entered(body):
	if body.has_method("set_near"):
		body.set_near(true)



func _on_Tip_detector_body_exited(body):
	if body.has_method("set_near"):
		body.set_near(false)

