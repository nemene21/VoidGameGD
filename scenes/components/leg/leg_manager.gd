extends Node
class_name LegManager

var id_on: int = 0
var leg_on: String

@export var legs: Array[Leg]
@export var step_delay = 0.15

func _ready() -> void:
	leg_on = legs[0].name
	$Timer.wait_time = step_delay

func next_leg() -> void:
	id_on += 1
	if id_on >= len(legs):
		id_on = 0
	
	leg_on = "<NONE>"
	$Timer.start()

func allowed(leg: Leg) -> bool:
	return leg.name == leg_on


func _on_timer_timeout() -> void:
	leg_on = legs[id_on].name
