extends Node2D
class_name GameScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	VfxManager.set_target(self)
	AudioManager.play_track("komunizam")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
