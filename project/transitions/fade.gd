extends CanvasLayer

signal faded

onready var animation_player = $AnimationPlayer


func fade_out():
	animation_player.play("fade_out")
	yield(animation_player, "animation_finished")
	emit_signal("faded")


func fade_in():
	animation_player.play("fade_in")
	#yield(animation_player, "animation_finished")
	emit_signal("faded")


func change_scene(level : String):
	fade_out()
	yield(self, "faded")
	get_tree().change_scene(level)
	fade_in()

func reload_scene():
	fade_out()
	yield(self, "faded")
	get_tree().reload_current_scene()
	fade_in()
