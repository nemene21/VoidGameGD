tool
extends Sprite

export(float, 0.0, 9.0, 1.0) var outline_width
export(Color) var outline_color

func _ready():
	
	update_outline_texture()

func _process(delta):
	
	$o000.position = Vector2(outline_width, 0)
	$o090.position = Vector2(outline_width, 0).rotated(1.57)
	$o180.position = Vector2(outline_width, 0).rotated(3.14)
	$o270.position = Vector2(outline_width, 0).rotated(4.71)
	
	$o000.material.set_shader_param("color", outline_color)
	$o090.material.set_shader_param("color", outline_color)
	$o180.material.set_shader_param("color", outline_color)
	$o270.material.set_shader_param("color", outline_color)
	
	if Engine.editor_hint: update_outline_texture()
	
func update_outline_texture():
	
	$o000.texture = texture
	$o090.texture = texture
	$o180.texture = texture
	$o270.texture = texture
