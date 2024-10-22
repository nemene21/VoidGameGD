extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_interaction_interacted() -> void:
	var scene: GameScene = get_tree().current_scene
	var animator: AnimationPlayer = scene.get_node("UI/AnimationPlayer")
	
	animator.play("conversation_start")
