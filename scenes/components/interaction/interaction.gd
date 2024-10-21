extends Area2D
class_name InteractionPoint

signal interacted
var player_in := false
var closest := false

func is_active() -> bool:
	return player_in and closest

func _process(delta: float) -> void:
	$Label.position.y = -15 + sin(Global.time * PI) * 4
	$Label.modulate.a = Global.dlerp($Label.modulate.a, float(is_active()), delta * 40) 

func _on_area_entered(area: Area2D) -> void:
	player_in = true
	var player := area.get_parent() as Player
	player.interactors.append(self)

func _on_area_exited(area: Area2D) -> void:
	player_in = false
	var player := area.get_parent() as Player
	player.interactors.remove_at(player.interactors.find(self))
