extends Area2D

var players_in = 0
export(String) var next_level 

func _ready():
	connect("body_entered",self,"on_body_entered")
	connect("body_exited",self,"on_body_exited")

func on_body_entered(body: NewPlayer):
	players_in+=1
	if players_in == 2:
		Fade.change_scene(next_level)
		#get_tree().change_scene(next_level)

func on_body_exited(body: NewPlayer):
	players_in-=1
