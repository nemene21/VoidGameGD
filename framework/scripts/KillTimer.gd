extends Timer

func _on_KillTimer_timeout():
	get_parent().queue_free()
