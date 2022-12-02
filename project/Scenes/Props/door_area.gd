extends Area2D

func _on_final_door_body_entered(body):
	print("a")
	print(body)
	get_parent().add_player()
	if  get_parent().players_in == 2:
		get_parent().change_next_lvl()


func _on_final_door_body_exited(body):
	print("b")
	get_parent().delete_player()
