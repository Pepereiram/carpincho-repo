extends MarginContainer

#Escape Levels
onready var Esc1 = $"%Esc1"
onready var Esc2 = $"%Esc2"
onready var Esc3 = $"%Esc3"
onready var Esc4 = $"%Esc4"
onready var Esc5 = $"%Esc5"
#Ascend Levels
onready var Asc1 = $"%Asc1"
onready var Asc2 = $"%Asc2"
onready var Asc3 = $"%Asc3"
onready var Asc4 = $"%Asc4"
onready var Asc5 = $"%Asc5"
onready var Asc6 = $"%Asc6"
onready var Asc7 = $"%Asc7"
onready var Asc8 = $"%Asc8"
#Boss Levels
onready var Boss0 =$"%Boss0"
onready var Boss1 =$"%Boss1"
#credits
onready var credits = $"%credits"

func _ready():
	hide()

func _input(event):
	if event.is_action_pressed("lvlMenu"):
		visible = !visible
		get_tree().paused = visible

#Pressed
#Esc Lvls
func _on_Esc1_pressed():
	get_tree().paused = false
	Fade.change_scene("res://Scenes/Levels/escape_lvl1.tscn")

func _on_Esc2_pressed():
	get_tree().paused = false
	Fade.change_scene("res://Scenes/Levels/escape_lvl2.tscn")

func _on_Esc3_pressed():
	get_tree().paused = false
	Fade.change_scene("res://Scenes/Levels/escape_lvl3.tscn")

func _on_Esc4_pressed():
	get_tree().paused = false
	Fade.change_scene("res://Scenes/Levels/escape_lvl4.tscn")

func _on_Esc5_pressed():
	get_tree().paused = false
	Fade.change_scene("res://Scenes/Levels/escape_lvl5.tscn")

#Asc Lvls
func _on_Asc1_pressed():
	get_tree().paused = false
	Fade.change_scene("res://Scenes/Levels/asc_lvl1.tscn")

func _on_Asc2_pressed():
	get_tree().paused = false
	Fade.change_scene("res://Scenes/Levels/asc_lvl2.tscn")

func _on_Asc3_pressed():
	get_tree().paused = false
	Fade.change_scene("res://Scenes/Levels/asc_lvl3.tscn")
	
func _on_Asc4_pressed():
	get_tree().paused = false
	Fade.change_scene("res://Scenes/Levels/asc_lvl4.tscn")

func _on_Asc5_pressed():
	get_tree().paused = false
	Fade.change_scene("res://Scenes/Levels/asc_lvl5.tscn")

func _on_Asc6_pressed():
	get_tree().paused = false
	Fade.change_scene("res://Scenes/Levels/asc_lvl6.tscn")

func _on_Asc7_pressed():
	get_tree().paused = false
	Fade.change_scene("res://Scenes/Levels/asc_lvl7.tscn")

func _on_Asc8_pressed():
	get_tree().paused = false
	Fade.change_scene("res://Scenes/Levels/asc_lvl8.tscn")

#Boss lvls
func _on_Boss0_pressed():
	get_tree().paused = false
	Fade.change_scene("res://Scenes/Levels/boss_lvl0.tscn")

func _on_Boss1_pressed():
	get_tree().paused = false
	Fade.change_scene("res://Scenes/Levels/boss_lvl1.tscn")

#credits
func _on_credits_pressed():
	get_tree().paused = false
	Fade.change_scene("res://menu/credits/endingAnimation.tscn")
