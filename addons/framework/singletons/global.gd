extends Node

func _ready() -> void:
	RenderingServer.set_default_clear_color(Color.BLACK)

func dlerp(a: Variant, b: Variant, c: Variant) -> Variant:
	var blend = 1.0 - pow(0.5, c)
	return lerp(a, b, blend)

func get_files(path: String) -> Array[String]:
	var dir = DirAccess.open(path)
	
	var filenames: Array[String] = []

	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		filenames.append(file_name)
		file_name = dir.get_next()
		
	return filenames

func remove_file_ending(filename: String) -> String:
	var dot = filename.find(".")
	return filename.left(dot)

var time := .0
func _process(delta) -> void:
	time += delta
