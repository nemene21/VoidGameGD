extends Node
class_name MoveComp

@export var automove := true
var velocity := Vector2.ZERO
var knockback:= Vector2.ZERO
var knockback_damping := 10.
var knockback_resistance := .0

@onready var parent := get_parent()

func lerp_vel(new: Vector2, speed: Variant) -> void:
	velocity = Global.dlerp(velocity, new, speed)

func add_knockback(adding: Vector2) -> void:
	knockback += adding * (1.0 - knockback_resistance)

func get_speed() -> Vector2:
	return velocity + knockback

func _process(delta: float) -> void:
	knockback = Global.dlerp(knockback, Vector2.ZERO, knockback_damping * delta)
	
	if !automove:
		return
	
	if parent is CharacterBody2D:
		parent.velocity = get_speed()
		parent.move_and_slide()
		return
	
	parent.global_position += get_speed() * delta
	
