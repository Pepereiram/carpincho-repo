extends Sprite

onready var anim_player = $AnimationPlayer
onready var anim_tree = $AnimationTree
onready var playback = anim_tree.get("parameters/playback")

func _ready():
	anim_tree.active = true	
	
func open():
	playback.travel("open")

func close():
	playback.travel("close")


