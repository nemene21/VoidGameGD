extends CharacterBody2D

var speed: float = 100
var acceleration: float = 15
@export var legs: Node2D
@export var move_comp: MoveComp
var direction := Vector2.ZERO

func _ready() -> void:
	VfxManager.set_target(get_parent())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input = Input.get_vector("left", "right", "up", "down").normalized()
	move_comp.lerp_vel(input * speed, acceleration * delta)
	
	var vel := move_comp.velocity
	
	## Move animation
	direction = Global.dlerp(direction, vel.normalized(), 20 * delta)
	$Body.global_rotation = direction.angle()
	$Body/Head.position.x = Global.dlerp(
		$Body/Head.position.x, vel.length() * 0.025 + 1, 20 * delta
	)
	var bob_head := sin(Global.time * PI * 4) * 0.15
	var bob_body := sin(Global.time * PI * 4 + PI * 0.25) * 0.15
	$Body/Head.scale = Global.dlerp(
		$Body/Head.scale, Vector2.ONE * (1 + bob_head * input.length()), 20 * delta
	)
	$Body/Body.scale = Global.dlerp(
		$Body/Body.scale, Vector2.ONE * (1 + bob_body * input.length()), 20 * delta
	)
	
	legs.global_position = global_position + move_comp.get_speed() * 0.25

func _on_health_died() -> void:
	VfxManager.explode_sprite($Sprite)
	queue_free()
