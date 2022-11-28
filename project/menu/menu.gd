extends MarginContainer

onready var play = $VBoxContainer/play
onready var exit =  $VBoxContainer/exit
onready var tutorial = $VBoxContainer/tutorial

func _ready():
	exit.connect("pressed",self, "_on_exit_pressed")
	play.connect("pressed",self,"_on_play_pressed")
	tutorial.connect("pressed", self, "_on_tutorial_pressed")
	
	
func _on_play_pressed():
	get_tree().change_scene("res://Scenes/Levels/escape_lvl1.tscn")	
	
func _on_exit_pressed():	
	get_tree().quit()
	
func _on_tutorial_pressed():
	get_tree().change_scene("res://Scenes/Levels/Tutorial/Tutorial.tscn")
