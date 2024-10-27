extends Sprite2D
class_name Leg

@export var foot: Node2D
@export var anchor: Node2D
@export var max_distance: float
@export var anim_speed: float = 15
@onready var desired_pos := global_position
@onready var ultimative_position := global_position
var step_allowed := false
@export var manager: LegManager = null
@export var leg_color: Color

var y_vel := .0

func _ready() -> void:
	$Line.default_color = leg_color

func allowed_by_manager() -> bool:
	if manager == null:
		return true
	return manager.allowed(self)

func step():
	if !allowed_by_manager():
		return
	
	var diff = ultimative_position - foot.global_position
	if diff.length() > max_distance:
		desired_pos = foot.global_position - diff.normalized() * max_distance * 0.15
		$AnimationPlayer.play("step")
		AudioManager.play_sound2d("step", global_position, 0.6, 1.0, 0.2)
	
	if manager != null:
		manager.next_leg()

func _process(delta: float) -> void:
	step()

	ultimative_position = Global.dlerp(ultimative_position, desired_pos, anim_speed * delta)
	global_position = ultimative_position
	
	## Line points
	$Line.global_position = Vector2.ZERO
	$Line.global_rotation = 0
	$Line.global_scale = Vector2.ONE
	$Line.points[0] = global_position
	$Line.points[1] = anchor.global_position
