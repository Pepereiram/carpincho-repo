extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var carpincho = $Carpincho
onready var timer = $Timer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if carpincho.dying and timer.is_stopped():
		timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	Fade.change_scene("res://menu/credits/endingAnimation.tscn")
	pass # Replace with function body.
