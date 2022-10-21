extends KinematicBody2D
onready var anim_press = $AnimationPlayer
onready var anim_press_t = $AnimationTree


func _ready():
	anim_press_t.active = true
	#anim_tree.active = true
	#Tip.get_node("cs").disabled = true
	#Tip.get_node("Sprite").hide()
