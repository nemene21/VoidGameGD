extends Node2D

export(int, 16, 48) var length = 16

export var active = true

var last_global_pos = global_position

func _process(delta):
	
	$Line.global_position = Vector2()

func _on_AddPointTimer_timeout():
	
	if active and !last_global_pos == global_position:
		
		$Line.add_point(global_position)
	
	if ($Line.get_point_count() > length or !active or last_global_pos == global_position) and $Line.get_point_count() != 0:
		
		$Line.remove_point(0)
	
	$AddPointTimer.start()
	
	last_global_pos = global_position
