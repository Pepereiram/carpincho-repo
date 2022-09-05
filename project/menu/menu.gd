extends MarginContainer

onready var play = $VBoxContainer/play
onready var exit =  $VBoxContainer/exit

func _ready():
	exit.connect("pressed",self, "_on_exit_pressed")
	play.connect("pressed",self,"_on_play_pressed")
	
	
func _on_play_pressed():
	get_tree().change_scene("res://Scenes/Hola.tscn")	
	
func _on_exit_pressed():	
	get_tree().quit()
