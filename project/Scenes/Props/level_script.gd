extends Node2D

var players_in = 0
export(String) var next_level 

func change_next_lvl():
	get_tree().change_scene(next_level)

func add_player():
	players_in += 1
	
func delete_player():
	players_in -= 1
	
