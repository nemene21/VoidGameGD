extends Area2D
class_name Hurtbox

@export var iframes := 3.0
@onready var parent := get_parent()

signal got_hit(damage: float, kb_dir: Vector2)

func hit(damage: float, kb_dir: Vector2) -> void:
	if parent.has_node("Health"):
		parent.get_node("Health").hurt(damage)
	got_hit.emit(damage, kb_dir)
