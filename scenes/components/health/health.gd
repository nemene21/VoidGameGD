extends Node

@export var max_hp: float
@export var hp: float
@onready var parent := get_parent()

signal died
signal got_hurt(damage)

## Caps hp to be from 0 to max_hp
func cap_hp() -> void:
	hp = clamp(hp, 0, max_hp)
	
	if is_dead():
		died.emit()

## Deals damage
func hurt(damage: float, flash: bool = true) -> void:
	hp -= damage
	cap_hp()
	
	got_hurt.emit(damage)
	
	if flash and parent.has_node("Flash"):
		parent.get_node("Flash").flash()

## Adds health
func heal(health: float) -> void:
	hurt(-health, false)

## Returns if hp == 0
func is_dead() -> bool:
	return hp == 0
