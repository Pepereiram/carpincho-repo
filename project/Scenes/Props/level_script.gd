extends Node2D

var players_in = 0
export(String) var next_level

onready var final_dor = $final_door
onready var final_dor2 = $final_door2

func change_next_lvl():
	
	final_dor.get_node("door").open()
	final_dor2.get_node("door").open()
	get_node("NewPlayer").set_physics_process(false)
	get_node("pj2").set_physics_process(false)
	yield(get_tree().create_timer(1.0), "timeout")
	Fade.change_scene(next_level)
	#get_tree().change_scene(next_level)

func add_player():
	players_in += 1

	
func delete_player():
	players_in -= 1
	
