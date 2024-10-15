extends Node

func save_json(path : String, data : Dictionary):
	
	var file = File.new()
	
	file.open("user://" + path, File.WRITE)
	
	file.store_string(to_json(data))
	
	file.close()

func load_json(path : String):
	
	var file = File.new()
	
	file.open("user://" + path, File.READ)
	
	var content = file.get_as_text()
	
	file.close()
	
	return parse_json(content)

func spring(from, to, vel, k):
	
	vel  += ( to - from ) * k
	from += vel
	
	return [from, vel]
