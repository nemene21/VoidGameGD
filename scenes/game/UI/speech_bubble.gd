@tool
extends PanelContainer

@onready var triangle := $Polygon2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	triangle.global_position.y = global_position.y + size.y * scale.y
