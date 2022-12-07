extends Sprite

const OUTLINE = preload("res://shaders/outline.gdshader")
var sprite_material = ShaderMaterial.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	set_material(sprite_material)

func red_outline():
	print("red")
	sprite_material.set_shader(OUTLINE)
	sprite_material.set_shader_param("outline_color",Color(1.0,0.0,0.0,1.0))	

func blue_outline():
	print("blue")
	sprite_material.set_shader(OUTLINE)
	sprite_material.set_shader_param("outline_color",Color(0.0,0.0,1.0,1.0))	

func green_outline():
	print("green")
	sprite_material.set_shader(OUTLINE)
	sprite_material.set_shader_param("outline_color",Color(0.0,1.0,0.0,1.0))	

func delete_outline():
	print("delete")
	sprite_material.set_shader(null)
