extends MarginContainer

onready var resume = $"%resume"
onready var restart = $"%restart"
onready var main_menu = $"%mainMenu"
onready var exit = $"%exit"
onready var master_volume = $"%MasterS"
onready var music_volume = $"%MusicS"
onready var sfx_volume = $"%sfxS"
onready var bgm = $AudioStreamPlayer

func _ready():
	resume.connect("pressed",self, "_on_resume_pressed")
	restart.connect("pressed",self, "_on_restart_pressed")
	main_menu.connect("pressed",self, "_on_main_menu_pressed")
	exit.connect("pressed",self, "_on_exit_pressed")
	master_volume.connect("value_changed", self, "_on_masterV_value_changed")
	music_volume.connect("value_changed", self, "_on_musicV_value_changed")
	sfx_volume.connect("value_changed", self, "_on_sfxV_value_changed")
	bgm.stop()
	hide()

func _input(event):
	if event.is_action_pressed("pauseMenu"):
		if bgm.playing:
			bgm.stop()
		else:
			bgm.play()
		visible = !visible
		get_tree().paused = visible

func _on_resume_pressed():
	bgm.stop()
	hide()
	get_tree().paused = false


func _on_restart_pressed():
	bgm.stop()
	get_tree().reload_current_scene()
	get_tree().paused = false
	
func _on_main_menu_pressed():
	bgm.stop()
	get_tree().paused = false
	get_tree().change_scene("res://menu/Mainmenu.tscn")
	
func _on_exit_pressed():
	get_tree().quit()

func _on_masterV_value_changed(value: float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(value))

func _on_musicV_value_changed(value: float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("BGM"), linear2db(value))

func _on_sfxV_value_changed(value: float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear2db(value))
