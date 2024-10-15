extends CharacterBody2D

const SPEED = 400

func _process(delta: float) -> void:
	var input_vector = Input.get_vector("left", "right", "up", "down").normalized()
	velocity = lerp(velocity, input_vector * SPEED, 0.4)
	move_and_slide()


func _on_timer_timeout() -> void:
	$AnimationPlayer.play("bop")
