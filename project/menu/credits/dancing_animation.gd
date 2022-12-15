extends Node2D

onready var anim_tree = $AnimationTree
onready var anim_player =$AnimationPlayer
onready var playback = anim_tree.get("parameters/playback")
onready var anim1 
onready var timer = $Timer
var velocity = 200
var distance = 0
var celebrate = true
var awa = 0

func _ready():
	anim_tree.active = true
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if anim1:
		position.x += 200 * delta
		if position.x > 600 :
			set_process(false)
			Fade.change_scene("res://menu/credits/ending_animation2.tscn")
	else:
		position.x += velocity  *  delta
		distance += 200 * delta
		if distance > 300:
			velocity = 0
			if celebrate:
					playback.travel("jump_owo")
					celebrate  = false
			if distance > 800:
				set_process(false)
				Fade.change_scene("res://menu/credits/NewCredits.tscn")
		
				
			

	
