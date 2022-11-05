class_name NewPlayer1
extends "res://Scenes/Entities/NewPlayer/NewPlayer.gd"

func _init():
	#inputs
	right = "move_right"
	left = "move_left"
	jump = "move_up"
	fire = "lanzar1"
	back =  "soltar1"
	look_up = "apuntar_arriba"
	look_down = "apuntar_abajo"





func _on_Tip_detector_body_exited(body):
	print("wuau")


func _on_Tip_detector_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print("dou")
