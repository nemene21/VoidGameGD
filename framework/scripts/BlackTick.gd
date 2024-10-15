extends Timer

func _ready():
	get_parent().modulate = Color(0, 0, 0, 1)


func _on_BlackTick_timeout():
	get_parent().modulate = Color(1, 1, 1, 1)
	
	queue_free()
