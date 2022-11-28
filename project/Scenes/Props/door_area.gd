extends Area2D

func _ready():
	connect("body_entered",self,"on_body_entered")
	connect("body_exited",self,"on_body_exited")


func on_body_entered(body: NewPlayer):
	get_parent().add_player()
	if  get_parent().players_in == 2:
		get_parent().change_next_lvl()

func on_body_exited(body: NewPlayer):
	get_parent().delete_player()

